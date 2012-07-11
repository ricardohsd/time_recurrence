require 'enumerator'

module Code5
  class TimeRecurrence
    include Enumerable

    def initialize(options)
      raise ArgumentError, ":starts option is required" unless options.key?(:starts)
      raise ArgumentError, "invalid :starts option"     unless options[:starts].is_a? Time
      raise ArgumentError, ":interval option is required" unless options.key?(:interval)
      raise ArgumentError, "invalid :interval option"     if options[:interval] == 0
      raise ArgumentError, ":repeat option is required" unless options.key?(:repeat)
      raise ArgumentError, "invalid :repeat option"     if options[:repeat] == 0

      options[:overlap_day] = true unless options.key?(:overlap_day)
      @options = options
      @starts = options.delete(:starts)
      @interval = options.delete(:interval)
      @repeat = options.delete(:repeat) - 1
    end

    def each(&block)
      events.each(&block)
    end

    def events
      @events ||= build_events
    end

    private

    def build_events
      events = [@starts]
      time = @starts

      @repeat.times do
        time = time + @interval

        break if time.day != @starts.day && !@options[:overlap_day]

        events << time
      end

      events
    end
  end
end
