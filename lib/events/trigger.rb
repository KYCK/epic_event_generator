require 'securerandom'
require 'json'

class Events
  class Trigger
    attr_accessor :type, :uuid

    def initialize
      @type = 'currentUser'
      @uuid = SecureRandom.uuid
    end

    def to_h
      { type: type, uuid: uuid }
    end

    def to_json
      to_h.to_json
    end

    def next_step!
      #no-op
    end
  end
end
