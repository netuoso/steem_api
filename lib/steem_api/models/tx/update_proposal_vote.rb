module SteemApi
  module Tx
    class UpdateProposalVote < SteemApi::SqlBase
      belongs_to :voter_record, foreign_key: :account, primary_key: :voter, class_name: 'SteemApi::Account'

      self.table_name = :TxUpdateProposalVotes
      
      scope :proposal, lambda { |id, invert = false|
        if !!invert
          where("? NOT IN (SELECT value FROM OPENJSON(proposal_ids,'$'))", id)
        else
          where("? IN (SELECT value FROM OPENJSON(proposal_ids,'$'))", id)
        end
      }
      
      scope :approve, lambda {|approve = true| where(approve: approve)}
    end
  end
end

# Structure
#
# SteemApi::Tx::Vote(
#   ID: integer,
#   tx_id: integer,
#   voter: varchar,
#   proposal_ids: varchar,
#   approve: boolean,
#   extensions: varchar,
#   timestamp: datetime
# )
