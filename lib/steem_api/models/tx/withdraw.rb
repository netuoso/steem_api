module SteemApi
  module Tx
    class Withdraw < SteemApi::SqlBase

      self.table_name = :TxWithdraws

    end
  end
end

# Structure
#
# SteemApi::Tx::Withdraw(
#   ID: integer,
#   tx_id: integer,
#   account: varchar,
#   vesting_shares: money,
#   timestamp: datetime
# )
