module WBench
  class MemoryHash < Hash
    def initialize(hash)
      # Remove 0 values as they indicate events that didn't occur
      hash = hash.delete_if { |key, value| value == 0 }
      hash.map { |key, value| [key, value] }

      # Order the results by value, lowest to highest
      hash.sort_by(&:last).each { |key, value| self[key] = value }
    end
  end
end
