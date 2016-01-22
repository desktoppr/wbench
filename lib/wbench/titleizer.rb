module WBench
  class Titleizer
    def initialize(title)
      @title = title.to_s.dup
    end

    def to_s
      @title.gsub!(/([a-z\d])([A-Z])/,'\1 \2')
      @title.gsub!(/\b('?[a-z])/) { $1.capitalize }
      @title.gsub!('Dom ', 'DOM ')
      @title = "#{@title}:"
    end
  end
end
