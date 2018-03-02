module SteemApi
  module Vo
    class ProducerReward < SteemApi::SqlBase

      self.table_name = :VOProducerRewards

    end
  end
end

# Structure
#
# SteemApi::Vo::ProducerReward(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   producer: varchar,
#   vesting_shares: money
# )
