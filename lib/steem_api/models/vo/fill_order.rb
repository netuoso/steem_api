module SteemApi
  module Vo
    class FillOrder < SteemApi::SqlBase

      self.table_name = :VOFillOrders

    end
  end
end

# Structure
#
# SteemApi::Vo::FillOrder(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   current_owner: varchar,
#   current_orderid: integer,
#   current_pays: varchar,
#   open_owner: varchar,
#   open_orderid: integer,
#   open_pays: varchar
# )
