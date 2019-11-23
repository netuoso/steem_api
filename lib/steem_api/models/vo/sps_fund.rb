module SteemApi
  module Vo
    class SpsFund < SteemApi::SqlBase

      self.table_name = :VOSpsFund

    end
  end
end

# Structure
#
# SteemApi::Vo::SpsFund(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   additional_funds: money
# )
