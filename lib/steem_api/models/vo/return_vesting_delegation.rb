module SteemApi
  module Vo
    class ReturnVestingDelegation < SteemApi::SqlBase

      self.table_name = :VOReturnVestingDelegations

    end
  end
end

# Structure
#
# SteemApi::Vo::ReturnVestingDelegation(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   account: varchar,
#   amount: money,
#   amount_symbol
# )
