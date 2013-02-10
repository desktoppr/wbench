module WBench
  class Benchmark
    def self.run(url, loops=nil)
      new(url).run(loops || DEFAULT_LOOPS)
    end

    def initialize(url)
      @url = url
    end

    def run(loops)
      @results = Results.new(@url, loops)

      loops.times { @results.add(browser_timing, app_response_time, asset_latency_time) }

      @results
    end

    private

    def browser_timing
      Timings::Browser.new(@url).result
    end

    def app_response_time
      Timings::App.new(@url).result
    end

    def asset_latency_time
      Timings::Latency.new(@url).result
    end
  end
end
