module SteemApi
  module Tx
    class AccountCreate < SteemApi::SqlBase

      self.table_name = :TxAccountCreates

    end
  end
end

# Structure
#
# SteemApi::Tx::AccountCreate(
#   ID: integer,
#   tx_id: integer,
#   fee: money,
#   delegation: money,
#   creator: varchar,
#   new_account_name: varchar,
#   owner_key: varchar,
#   active_key: varchar,
#   posting_key: varchar,
#   memo_key: varchar_max,
#   json_metadata: varchar_max,
#   timestamp: datetime
# )
