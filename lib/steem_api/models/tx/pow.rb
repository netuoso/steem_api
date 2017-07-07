module SteemApi
  module Tx
    class Pow < SteemApi::SqlBase

      self.table_name = :TxPows

    end
  end
end

# Structure
#
# SteemApi::Tx::Pow(
#   ID: integer,
#   tx_id: integer,
#   worker_account: varchar,
#   block_id: varchar,
#   timestamp: datetime
# )
