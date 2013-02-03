class RowFormatter
  def initialize(result)
    @name   = result.first
    @values = result.last
  end

  def to_s
    name_s + fastest_s + median_s + slowest_s
  end

  private

  def name_s
    name = @name.to_s.dup
    name.gsub!(/([a-z\d])([A-Z])/,'\1 \2')
    name.gsub!(/\b('?[a-z])/) { $1.capitalize }
    name.gsub!('Dom ', 'DOM ')
    name = "#{name}:"
    name.ljust(35)
  end

  def fastest_s
    "#{@values.min}ms".ljust(10).colorize(:green)
  end

  def slowest_s
    "#{@values.max}ms".ljust(10).colorize(:red)
  end

  def median_s
    median = @values[ @values.length / 2 ]

    "#{median}ms".ljust(10).colorize(:blue)
  end
end
