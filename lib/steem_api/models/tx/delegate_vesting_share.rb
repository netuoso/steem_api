module SteemApi
  module Tx
    class DelegateVestingShare < SteemApi::SqlBase

      self.table_name = :TxDelegateVestingShares

    end
  end
end

# Structure
#
# SteemApi::Tx::DelegateVestingShare(
#   ID: integer,
#   tx_id: integer,
#   delegator: varchar,
#   delegatee: varchar,
#   vesting_shares: money,
#   timestamp: datetime
# )
