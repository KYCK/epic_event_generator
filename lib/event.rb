require 'json'
require 'securerandom'
require 'date'

class Event
 
  ONE_DAY       = 1
  ONE_MONTHS    = ONE_DAY    * 30
  SIX_MONTHS    = ONE_MONTHS * 6
  ONE_YEARS     = ONE_DAY    * 365
  EIGHT_YEARS   = ONE_YEARS  * 8
  SIXTEEN_YEARS = ONE_YEARS  * 16

  class << self
    def generate(event_date = :today)
      event_hash(event_date).to_json
    end

    def event_hash(event_date)
      {
        eventTarget: "card",
        eventType: %w(created updated deleted).sample,
        eventTimestamp: gen_timestamp(event_date),
        eventTrigger: {
          type: "currentUser",
          uuid: SecureRandom.uuid
        },
        data: {
          uuid: SecureRandom.uuid,
          expiresOn: "2015-06-01T00:00:00+00:00",
          firstName: gen_string,
          lastName: gen_string,
          kind: %w(staff player).sample,
          avatar: gen_string,
          birthdate: gen_birthdate,
          status: %w(pending approved revoked).sample
        }
      }
    end

    def gen_date(range)
      DateTime.now - range.to_a.sample
    end

    def gen_timestamp(event_date)
      if event_date == :today
        DateTime.now
      else
        gen_date(ONE_DAY..SIX_MONTHS)
      end
    end

    def gen_birthdate
      gen_date(EIGHT_YEARS..SIXTEEN_YEARS)
    end

    def gen_string
      ('a'..'z').to_a.shuffle[0,(3..12).to_a.sample].join
    end
  end
end
