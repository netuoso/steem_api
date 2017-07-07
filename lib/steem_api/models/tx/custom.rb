module SteemApi
  module Tx
    class Custom < SteemApi::SqlBase

      self.table_name = :TxCustoms

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
