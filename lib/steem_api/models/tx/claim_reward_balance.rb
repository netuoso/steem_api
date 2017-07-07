module SteemApi
  module Tx
    class ClaimRewardBalance < SteemApi::SqlBase

      self.table_name = :TxClaimRewardBalances

    end
  end
end

# Structure
#
# SteemApi::Tx::ClaimRewardBalance(
#   ID: integer,
#   tx_id: integer,
#   account: varchar,
#   reward_steem: money,
#   reward_sbd: money,
#   reward_vests: money,
#   timestamp: datetime
# )
