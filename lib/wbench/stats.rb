module WBench
  class Stats < SimpleDelegator
    def median
      self[length / 2]
    end

    def sum
      inject(:+)
    end

    def sample_variance
      (1 / length.to_f*sum)
    end

    def std_dev
      Math.sqrt(sample_variance).to_i
    end
  end
end
