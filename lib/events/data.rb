require 'securerandom'
require 'date'
require 'json'

class Events
  class Data
    attr_accessor :uuid, :expiresOn, :firstName, :lastName,
                  :kind, :avatar, :status

    def initialize
      @uuid      = SecureRandom.uuid
      @firstName = gen_name
      @lastName  = gen_name
      @kind      = %w(player staff).sample
      @avatar    = gen_name
      @status    = 'pending'
    end

    EXPIRATION_DATE = DateTime.new(2015, 6, 1)

    def expiresOn
      EXPIRATION_DATE.to_s
    end

    def now
      @now ||= DateTime.now
    end

    # ONE_DAY       = 60 * 60 * 34
    ONE_DAY       = 1
    ONE_MONTH     = ONE_DAY * 30
    ONE_YEARS     = ONE_DAY * 365
    EIGHT_YEARS   = ONE_YEARS * 8
    SIXTEEN_YEARS = ONE_YEARS * 16

    def birthdate
      return @birthdate if @birthdate
      time_ago = (EIGHT_YEARS..SIXTEEN_YEARS).to_a.sample
      @birthdate ||= (now - time_ago).to_s
    end

    def gen_date(direction, options = {})
      min_time_from_now = options[:min]
      max_time_from_now = options[:max]
      time_from_now = (min_time_from_now..max_time_from_now).to_a.sample
      op = direction == :past ? :- : :+
      now.send(op, time_from_now).to_s
    end

    def to_h
      {
        uuid: uuid,
        expiresOn: expiresOn,
        firstName: firstName,
        lastName: lastName,
        kind: kind,
        avatar: avatar,
        birthdate: birthdate,
        status: status
      }
    end

    def to_json
      to_h.to_json
    end

    def next_status!
      if @status == 'pending'
        @status = 'approved'
      elsif @status == 'approved'
        @status = 'revoked'
      end
    end

    def next_step!
      next_status!
    end

    def gen_name
      ('a'..'z').to_a.shuffle[0,(3..12).to_a.sample].join
    end
  end
end
