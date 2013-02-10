module WBench
  class Benchmark
    def self.run(url, loops=nil)
      new(url).run(loops || DEFAULT_LOOPS)
    end

    def initialize(url)
      @url = url
      @browser = Browser.new(url)
    end

    def run(loops)
      @results = Results.new(@url, loops)

      loops.times do
        @browser.visit do
          @results.add(app_server_results, browser_results, latency_results)
        end
      end

      @results
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
