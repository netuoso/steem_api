module SteemApi
  module Tx
    class DeleteComment < SteemApi::SqlBase

      self.table_name = :TxDeleteComments

    end
  end
end

# Structure
#
# SteemApi::Tx::DeleteComment(
#   ID: integer,
#   tx_id: integer,
#   author: varchar,
#   permlink: varchar_max,
#   timestamp: datetime
# )
