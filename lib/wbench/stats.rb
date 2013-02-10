module WBench
  class Stats < SimpleDelegator
    def median
      sort[length / 2]
    end

    def sum
      inject(:+)
    end

    def mean
      sum / length.to_f
    end

    def sample_variance
      (inject(0) { |variance, value| variance + ((value - mean) ** 2) }) / length
    end

    def std_dev
      Math.sqrt(sample_variance)
    end
  end
end
