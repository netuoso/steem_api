module SteemApi
  module Tx
    class LimitOrder < SteemApi::SqlBase

      self.table_name = :TxLimitOrders

    end
  end
end

# Structure
#
# SteemApi::Tx::LimitOrder(
#   ID: integer,
#   tx_id: integer,
#   owner: varchar,
#   orderid: integer,
#   cancel: boolean,
#   amount_to_sell: money,
#   min_to_receive: money,
#   exchange_rate_base: money,
#   exchange_rate_quote: money,
#   fill_or_kill: boolean,
#   expiration: datetime,
#   timestamp: datetime
# )
