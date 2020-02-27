module SteemApi
  module Tx
    class Custom < SteemApi::SqlBase

      self.table_name = :TxCustoms
      
      scope :any_required_auths, lambda { |required_auth|
        where("? IN(JSON_VALUE(required_auths, '$'))", required_auth)
      }
      scope :any_required_posting_auths, lambda { |required_posting_auth|
        where("? IN(JSON_VALUE(required_posting_auths, '$'))", required_posting_auth)
      }
    end
  end
end

# Structure
#
# SteemApi::Tx::Custom(
#   ID: integer,
#   tx_id: integer,
#   tid: varchar,
#   json_metadata: varchar_max,
#   timestamp: datetime
# )
