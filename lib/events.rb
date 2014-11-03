require 'json'
require 'events/event'
require 'events/data'
require 'events/trigger'

class Events
  attr_reader :event, :trigger
  def initialize
    @event       = Event.new
    @trigger     = Trigger.new
  end

  def next_step!
    objs.each { |o| o.next_step! }
  end

  def objs
    [@event, @trigger]
  end

  def to_h
    {
      event: event.to_h,
      trigger: trigger.to_h
    }
  end

  def to_json
    json = '{'
    json << '"event":'
    json << event.to_json
    json << ','
    json << '"trigger":'
    json << trigger.to_json
    json << '}'
    json
  end
end
