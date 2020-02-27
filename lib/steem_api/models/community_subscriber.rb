module SteemApi
  class CommunitySubscriber < SteemApi::SqlBase

    self.table_name = :CommunitiesSubscribers
    
    belongs_to :community_record, foreign_key: :community, class_name: 'SteemApi::Community', primary_key: :name
    belongs_to :account_record, foreign_key: :subscriber, class_name: 'SteemApi::Account', primary_key: :name
    
    scope :community, lambda {|community| where(community: community)}
    scope :subscriber, lambda {|subscriber| where(subscriber: subscriber)}
    
    scope :query, lambda { |query, options = {include_roles: false}|
      where(community: Community.query(query, options).select(:name))
    }
  end
end

# Structure
#
# SteemApi::CommunitySubscriber(
#   community varchar,
#   subscriber varchar
# )
