module SteemApi
  module Vo
    class CommentBenefactorReward < SteemApi::SqlBase

      self.table_name = :VOCommentBenefactorRewards

    end
  end
end

# Structure
#
# SteemApi::Vo::CurationReward(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   benefactor: varchar,
#   author: varchar,
#   permlink: varchar,
#   sbd_payout: money
#   steem_payout: money
#   vesting_payout: decimal(18,6)
# )
