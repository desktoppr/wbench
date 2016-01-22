module WBench
  class MemoryRowFormatter
    def initialize(name, data)
      @name  = name
      @stats = Stats.new(data)
    end

    def to_s
      if @stats.compact.size == 0
        name_s + no_result_s
      else
        name_s + lowest_s + median_s + highest_s + std_dev_s
      end
    end

    private

    def name_s
      @name.ljust(35)
    end

    def no_result_s
      ColoredString.new('Unable to be recorded'.center(40), :light_red)
    end

    def lowest_s
      ColoredString.new( (divide(@stats.min) + "Mb").ljust(10), :green)
    end

    def highest_s
      ColoredString.new( (divide(@stats.max) + "Mb").ljust(10), :red)
    end

    def median_s
      ColoredString.new( (divide(@stats.median) + "Mb").ljust(10), :blue)
    end

    def std_dev_s
      ColoredString.new( (divide(@stats.std_dev.to_i) + "Mb").ljust(10), :yellow)
    end

    def divide(i)
      (i.to_i / 1024 / 1024).to_s
    end
  end
end
