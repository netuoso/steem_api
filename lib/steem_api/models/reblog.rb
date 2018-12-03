module SteemApi
  class Reblog < SteemApi::SqlBase

    self.table_name = :Reblogs
    
    belongs_to :account, foreign_key: :account, class_name: 'Account', primary_key: :name
    belongs_to :author_account, foreign_key: :author, class_name: 'Account', primary_key: :name
    
    def comment; Comment::find_by(author: author, permlink: permlink); end
  end
end

# Structure
#
# SteemApi::Follower(
#   account varchar,
#   author varchar,
#   permlink varchar,
#   timestamp: datetime
# )
