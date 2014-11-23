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
          amountPaid: (1..1000).to_a.sample,
          approvedOn: gen_date(ONE_DAY..ONE_MONTHS),
          avatar: gen_string,
          avatarUri: gen_string,
          avatarVersion: gen_string,
          birthdate: gen_birthdate,
          cardedUserId: SecureRandom.uuid,
          cardedFor: SecureRandom.uuid,
          createdAt: gen_date(ONE_MONTHS..SIX_MONTHS),
          documentIds: 1.upto(3).map { SecureRandom.uuid },
          duplicateLookupHash: SecureRandom.uuid,
          expiresOn: "2015-06-01T00:00:00+00:00",
          firstName: gen_string,
          hasDuplicates: [true, false].sample,
          inactiveOn: [gen_date(ONE_DAY..ONE_MONTHS), nil].sample,
          isRenewal: [true, false].sample,
          kind: %w(staff player).sample,
          kyckId: SecureRandom.uuid,
          lastName: gen_string,
          messageStatus: %w(pending approved revoked).sample,
          middleName: gen_string,
          migratedId: SecureRandom.uuid,
          noteIds: 1.upto(3).map { SecureRandom.uuid },
          orderId: SecureRandom.uuid,
          orderItemId: SecureRandom.uuid,
          processedOn: gen_date(ONE_DAY..ONE_MONTHS),
          sanctioningBodyId: SecureRandom.uuid,
          status: %w(pending approved revoked).sample,
          updatedAt: gen_timestamp(:today)
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
