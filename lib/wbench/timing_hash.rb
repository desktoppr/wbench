module WBench
  class TimingHash < Hash
    def initialize(hash)
      # Remove 0 values as they indicate events that didn't occur
      hash = hash.delete_if { |key, value| value == 0 }

      # Grab the start time and offset the values against it.
      start_time = hash.min_by(&:last).last
      hash = hash.map { |key, value| [key, value - start_time] }

      # Order the results by value, lowest to highest
      hash.sort_by(&:last).each { |key, value| self[key] = value }
    end
  end
end
