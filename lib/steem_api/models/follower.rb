module SteemApi
  class Follower < SteemApi::SqlBase

  self.table_name = :Followers
  
  belongs_to :follower_account, foreign_key: :follower, class_name: 'Account', primary_key: :name
  belongs_to :following_account, foreign_key: :following, class_name: 'Account', primary_key: :name
  
  end
end

# Structure
#
# SteemApi::Follower(
#   follower varchar,
#   following varchar
# )
