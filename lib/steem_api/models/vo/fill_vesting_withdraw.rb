module SteemApi
  module Vo
    class FillVestingWithdraw < SteemApi::SqlBase

      self.table_name = :VOFillVestingWithdraws

    end
  end
end

# Structure
#
# SteemApi::Vo::FillVestingWithdraw(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   from_account: varchar,
#   to_account: varchar,
#   withdrawn: varchar,
#   deposited: varchar
# )
