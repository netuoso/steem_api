module SteemApi
  module Vo
    class AuthorReward < SteemApi::SqlBase

      self.table_name = :VOAuthorRewards

    end
  end
end

# Structure
#
# SteemApi::Vo::AuthorReward(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   author: varchar,
#   permlink: varchar,
#   sbd_payout: money,
#   steem_payout: money,
#   vesting_payout: money
# )
