module WBench
  class Benchmark
    def self.run(url, options = {})
      new(url, options).run(options[:loops] || DEFAULT_LOOPS)
    end

    def initialize(url, options)
      @url = url
      @browser = Browser.new(url, options[:browser] || DEFAULT_BROWSER)
      
      # allow colors
      $NO_COLOR = false
      
      # set the gist settings if the flag was present
      if options[:gist_name]
        # specify whether to create a gist with the options specified or defaults
        @gist_results = {name: options[:gist_name] || "WBench", secret: options[:secret] || false}
        # set global no color to true (so that ASCII coloring does not appear in the Gist)
        $NO_COLOR = true
      end
    end

    def run(loops)
      results = Results.new(@url, loops).tap do |results|
        loops.times do
          @browser.visit { results.add(app_server_results, browser_results, latency_results) }
        end
      end
      
      # return the gist response or console results
      @gist_results ? WBench::GistWriter.write_gist(results, @gist_results) : results
    end

    private

    def app_server_results
      Timings::AppServer.new(@browser).result
    end

    def browser_results
      Timings::Browser.new(@browser).result
    end

    def latency_results
      Timings::Latency.new(@browser).result
    end
  end
end
