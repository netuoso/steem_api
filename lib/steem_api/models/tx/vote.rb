module SteemApi
  module Tx
    class Vote < SteemApi::SqlBase

      self.table_name = :TxVotes
    
    end
  end
end

# Structure
#
# SteemApi::Tx::Vote(
#   ID: integer,
#   tx_id: integer,
#   voter: varchar,
#   author: varchar,
#   permlink: varchar,
#   weight: integer,
#   timestamp: datetime
# )
