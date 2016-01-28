module WBench
  class TimingRowFormatter
    def initialize(name, data)
      @name  = name
      @stats = Stats.new(data)
    end

    def to_s
      if @stats.compact.size == 0
        name_s + no_result_s
      else
        name_s + fastest_s + median_s + slowest_s + std_dev_s
      end
    end

    private

    def name_s
      @name.ljust(35)
    end

    def no_result_s
      ColoredString.new('Unable to be recorded'.center(40), :light_red)
    end

    def fastest_s
      ColoredString.new("#{@stats.min}ms".ljust(10), :green)
    end

    def slowest_s
      ColoredString.new("#{@stats.max}ms".ljust(10), :red)
    end

    def median_s
      ColoredString.new("#{@stats.median}ms".ljust(10), :blue)
    end

    def std_dev_s
      ColoredString.new("#{@stats.std_dev.to_i}ms".ljust(10), :yellow)
    end
  end
end
