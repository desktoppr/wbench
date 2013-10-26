module WBench
  @no_color = false
  class << self; attr_accessor :no_color; end
end

class String


  def colorout(params)
    WBench.no_color ? self : colorize(params)
  end
    
end
