module SteemApi
  class CommunityRole < SteemApi::SqlBase

    self.table_name = :CommunitiesRoles
    
    belongs_to :community_record, foreign_key: :community, class_name: 'SteemApi::Community', primary_key: :name
    belongs_to :account_record, foreign_key: :account, class_name: 'SteemApi::Account', primary_key: :name
    
    scope :account, lambda { |account| where(account: account) }
    
    scope :mode, lambda { |mode| where(role: mode) }
    scope :guests, -> { mode 'guest' }
    scope :members, -> { mode 'member' }
    scope :mods, -> { mode 'mod' }
    scope :admins, -> { mode 'admin' }
    scope :muted, -> { mode 'muted' }
    
    scope :community, lambda {|community| where(community: community)}
    scope :account, lambda {|account| where(account: account)}
    
    scope :query, lambda { |query, options = {include_roles: false}|
      where("community IN(?) OR account LIKE ? OR LOWER(title) LIKE ?",
        Community.query(query, options).select(:name),
        "%#{query}%",
        "%#{query.downcase}%")
    }
  end
end

# Structure
#
# SteemApi::CommunityRole(
#   community varchar,
#   account varchar,
#   role varchar,
#   title varchar
# )
