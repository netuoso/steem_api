module SteemApi
  module Vo
    class LiquidityReward < SteemApi::SqlBase

      self.table_name = :VOLiquidityRewards

    end
  end
end

# Structure
#
# SteemApi::Vo::LiquidityReward(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   owner: varchar,
#   payout: money
# )
