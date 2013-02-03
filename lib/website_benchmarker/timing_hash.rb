module WebsiteBenchmarker
  class TimingHash < Hash
    def initialize(json)
      # Remove 0 values as they indicate events that didn't occur
      json = json.delete_if { |key, value| value == 0 }

      # Grab the start time and offset the values against it.
      # Also reverse the values here so that the start ones are first
      start_time = json.min_by(&:last).last

      json.map { |key, value| [key, value - start_time] }.reverse.each do |key, value|
        self[key] = value
      end
    end
  end
end
