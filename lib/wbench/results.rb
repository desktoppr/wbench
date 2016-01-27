module WBench
  class Results
    attr_accessor :url, :loops, :time, :browser, :latency, :app_server

    def initialize(url, loops)
      @url        = url
      @loops      = loops
      @time       = Time.now.asctime
      @browser    = {}
      @latency    = {}
      @app_server = []
    end

    def add(app_server, browser, latency)
      browser.each do |type, value|
        @browser[type] = {}

        value.each do |key, value|
          @browser[type][key] ||= []
          @browser[type][key] << value
        end
      end

      latency.each do |key, value|
        @latency[key] ||= []
        @latency[key] << value
      end

      @app_server << app_server
    end

    def to_s
      ResultsFormatter.new(self).to_s
    end
  end
end
