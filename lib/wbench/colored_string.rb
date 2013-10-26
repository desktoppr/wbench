module WBench
  class ColoredString < String
    def initialize(string, color)
      if WBench.color_output
        super(string.colorize(color))
      else
        super(string)
      end
    end
  end
end
