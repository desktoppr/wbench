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
      print_with_color('Unable to be recorded'.center(40), :light_red)
    end

    def fastest_s
      print_with_color("#{@stats.min}ms".ljust(10), :green)
    end

    def slowest_s
      print_with_color("#{@stats.max}ms".ljust(10), :red)
    end

    def median_s
      print_with_color("#{@stats.median}ms".ljust(10), :blue)
    end

    def std_dev_s
      print_with_color("#{@stats.std_dev.to_i}ms".ljust(10), :yellow)
    end
    
    def print_with_color(str, color)
      # it no color is set, return without color
      $NO_COLOR ? str : str.colorize(color)
    end
  end
end
