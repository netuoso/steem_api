module SteemApi
  module Vo
    class CurationReward < SteemApi::SqlBase

      self.table_name = :VOCurationRewards

    end
  end
end

# Structure
#
# SteemApi::Vo::CurationReward(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   curator: varchar,
#   author: varchar,
#   permlink: varchar,
#   reward: varchar
# )
