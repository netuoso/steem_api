module SteemApi
  module Tx
    class Transfer < SteemApi::SqlBase

      self.table_name = :TxTransfers

    end
  end
end

# Structure
#
# SteemApi::Tx::Transfer(
#   ID: integer,
#   tx_id: integer,
#   type: varchar,
#   from: varchar,
#   to: varchar,
#   amount: money,
#   amount_symbol: varchar,
#   memo: text,
#   request_id: integer,
#   timestamp: datetime
# )
