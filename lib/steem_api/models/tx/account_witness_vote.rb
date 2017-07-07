module SteemApi
  module Tx
    class AccountWitnessVote < SteemApi::SqlBase

      self.table_name = :TxAccountWitnessVotes

    end
  end
end

# Structure
#
# SteemApi::Tx::AccountWitnessVote(
#   ID: integer, 
#   tx_id: integer, 
#   account: varchar, 
#   witness: varchar, 
#   approve: boolean, 
#   timestamp: datetime
# )
