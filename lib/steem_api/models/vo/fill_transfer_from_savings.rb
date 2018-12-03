module SteemApi
  module Vo
    class FillTransferFromSavings < SteemApi::SqlBase

      self.table_name = :VOFillTransferFromSavings

    end
  end
end

# Structure
#
# SteemApi::Vo::FillTransferFromSavings(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   from: varchar,
#   to: varchar,
#   amount: money,
#   amount_symbol,
#   requestid: bigint,
#   memo: text
# )
