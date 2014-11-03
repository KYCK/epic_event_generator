require 'date'
require 'json'
require 'events/data'

class Events
  class Event
    attr_accessor :target, :data
    def initialize
      @target    = 'card'
      @data      = Data.new
    end

    def to_h
      {
        name: name,
        target: target,
        method: method,
        timestamp: timestamp,
        data: data.to_h
      }
    end

    def now
      @now ||= DateTime.now
    end

    def timestamp
      self.send "gen_#{current_card_method}_event_date"
    end

    def gen_created_event_date
      gen_date :past, min: 61, max: 90
    end
    
    def gen_updated_event_date
      gen_date :past, min: 31, max: 60
    end

    def gen_deleted_event_date
      gen_date :past, min: 1, max: 30
    end

    def gen_date(direction, options = {})
      min_time_from_now = options[:min]
      max_time_from_now = options[:max]
      time_from_now = (min_time_from_now..max_time_from_now).to_a.sample
      op = direction == :past ? :- : :+
      now.send(op, time_from_now).to_s
    end

    def name
      "#{target}#{method.capitalize}"
    end

    def current_card_method
      @current_card_method ||= card_methods[card_method_index]
    end
    alias :method :current_card_method

    def card_method_index
      @card_method_index ||= 0
    end

    def next_card_method
      @card_method_index += 1
    end

    def card_methods
      @card_methods ||= %w(created updated deleted)
    end

    def flush_cache
      @current_card_method = nil
    end

    def to_json
      to_h.to_json
    end

    def next_step!
      next_card_method
      flush_cache
      @data.next_step!
    end
  end
end
