module WBench
  class Benchmark
    def self.run(url, options = {})
      new(url, options[:browser]).run(options[:loops] || DEFAULT_LOOPS)
    end

    def initialize(url, browser)
      @url = url
      @browser = Browser.new(url, browser || DEFAULT_BROWSER)
    end

    def run(loops)
      Results.new(@url, loops).tap do |results|
        loops.times do
          @browser.visit { results.add(app_server_results, browser_results, latency_results) }
        end
      end
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
