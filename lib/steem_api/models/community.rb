module SteemApi
  class Community < SteemApi::SqlBase

    self.table_name = :Communities
    
    has_many :roles, foreign_key: :community, class_name: 'SteemApi::CommunityRole', primary_key: :name
    has_many :guest_roles, -> { guests }, foreign_key: :community, class_name: 'SteemApi::CommunityRole', primary_key: :name
    has_many :member_roles, -> { members }, foreign_key: :community, class_name: 'SteemApi::CommunityRole', primary_key: :name
    has_many :mod_roles, -> { mods }, foreign_key: :community, class_name: 'SteemApi::CommunityRole', primary_key: :name
    has_many :admin_roles, -> { admins }, foreign_key: :community, class_name: 'SteemApi::CommunityRole', primary_key: :name
    has_many :muted_roles, -> { muted }, foreign_key: :community, class_name: 'SteemApi::CommunityRole', primary_key: :name
    
    has_many :role_accounts, through: :roles, source: :account_record
    has_many :guests, through: :guest_roles, source: :account_record
    has_many :members, through: :member_roles, source: :account_record
    has_many :mods, through: :mod_roles, source: :account_record
    has_many :admins, through: :admin_roles, source: :account_record
    has_many :muted, through: :muted_roles, source: :account_record
    
    has_many :subscribers, foreign_key: :community, class_name: 'SteemApi::CommunitySubscriber', primary_key: :name
    has_many :subscriber_accounts, through: :subscribers, source: :account_record
    
    has_many :comments, foreign_key: :category, class_name: 'SteemApi::Comment', primary_key: :name
    has_many :authors, -> { distinct }, through: :comments, source: :author_record
    has_many :tags, -> { distinct }, through: :comments, source: :tags
        
    scope :mode, lambda { |type| where(type: type) }
    scope :topics, -> { mode 1 }
    scope :journals, -> { mode 2 }
    scope :councils, -> { mode 3 }
    
    scope :language, lambda { |language| where(language: language) }
    scope :nsfw, lambda { |nsfw = true| where(nsfw: nsfw) }
    
    scope :tagged, lambda { |tag|
      comments = SteemSQL::Comment.where("category LIKE 'hive-%'")
      comments = comments.joins(:community_record)
      comments = comments.tagged(tag, exclude_category: true)
        
      where(name: comments.select(:category))
    }
    
    scope :query, lambda { |query, options = {include_roles: false}|
      query_clause = []
      
      query_clause << "LOWER([Communities].[name]) LIKE ?"
      query_clause << "LOWER([Communities].[title]) LIKE ?"
      query_clause << "LOWER([Communities].[about]) LIKE ?"
      query_clause << "LOWER([Communities].[description]) LIKE ?"
      
      if !!options.fetch(:include_roles, false)
        query_clause << "[Communities].[name] IN ( SELECT [CommunitiesRoles].[community] FROM [CommunitiesRoles] WHERE [CommunitiesRoles].[account] LIKE ?)"
        query_clause << "[Communities].[name] IN ( SELECT [CommunitiesRoles].[community] FROM [CommunitiesRoles] WHERE LOWER([CommunitiesRoles].[title]) LIKE ?)"
      end
      
      query = ["%#{query.downcase}%"] * query_clause.size
      where(query_clause.join(' OR '), *query)
    }
    
    def tag_names
      tags.pluck(:tag)
    end
  end
end

# Structure
#
# SteemApi::Community(
#   name varchar,
#   type varchar,
#   title varchar,
#   about varchar,
#   description varchar,
#   flag_text varchar,
#   language varchar,
#   nsfw boolean,
#   TS timestamp,
# )
