module SteemApi
  module Tx
    class AccountWitnessVote < SteemApi::SqlBase
      belongs_to :account_record, foreign_key: :account, primary_key: :name, class_name: 'SteemApi::Account'
      belongs_to :witness_record, foreign_key: :witness, primary_key: :name, class_name: 'SteemApi::Account'
      
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
