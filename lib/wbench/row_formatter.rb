module WBench
  class RowFormatter
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
      'Unable to be recorded'.center(40).colorize(:light_red)
    end

    def fastest_s
      "#{@stats.min}ms".ljust(10).colorize(:green)
    end

    def slowest_s
      "#{@stats.max}ms".ljust(10).colorize(:red)
    end

    def median_s
      "#{@stats.median}ms".ljust(10).colorize(:blue)
    end

    def std_dev_s
      "#{@stats.std_dev.to_i}ms".ljust(10).colorize(:yellow)
    end
  end
end
