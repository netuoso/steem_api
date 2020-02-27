module SteemApi
  class Comment < SteemApi::SqlBase

    self.table_name = :Comments
    
    has_many :tags, foreign_key: 'comment_ID'
    
    belongs_to :author_record, foreign_key: :author, class_name: 'SteemApi::Account', primary_key: :name
    belongs_to :community_record, foreign_key: :category, class_name: 'SteemApi::Community', primary_key: :name
    
    scope :depth, lambda { |depth| where(depth: depth) }
    
    scope :community, lambda { |community|
      case community
      when String then where(category: community)
      else
        where(category: community.name)
      end
    }
    
    scope :before, lambda { |before, field = 'created'| where("#{field} < ?", before) }
    scope :after, lambda { |after, field = 'created'| where("#{field} > ?", after) }
    scope :today, -> { after(1.day.ago) }
    scope :yesterday, -> { before(1.day.ago).after(2.days.ago) }
    
    scope :normalized_json, -> { where("json_metadata LIKE '{%}' AND ISJSON(json_metadata) > 0") }
    
    scope :app, lambda { |app|
      normalized_json.where("JSON_VALUE(json_metadata, '$.app') LIKE ?", "#{app}/%")
    }
    
    scope :app_version, lambda { |version|
      normalized_json.where("JSON_VALUE(json_metadata, '$.app') LIKE ?", "%/#{version}")
    }
    
    scope :community, lambda {|community| joins(:community_record).where(category: community)}
    scope :author, lambda {|author| joins(:author_record).where(author: author)}
    
    scope :tagged, lambda { |tag, options = {exclude_category: false}|
      exclude_category = !!options[:exclude_category]
      
      if exclude_category
        where(id: SteemSQL::Tag.where(tag: tag).select(:comment_ID))
      else
        where("ID IN(?) OR category = ?", SteemSQL::Tag.where(tag: tag).select(:comment_ID), tag)
      end
    }
    
    scope :decorate_metadata, -> {
      previous_select = if all.select_values.none?
        Arel.star
      else
        all.select_values
      end
      
      r = normalized_json.select(previous_select)
      
      %w(tags image links app format).each do |key|
        r = r.select("JSON_VALUE(json_metadata, '$.#{key}') AS metadata_#{key}")
      end
      
      r
    }
    
    scope :beneficiaries, lambda { |account|
      where("JSON_VALUE(beneficiaries, '$.account') IN(?)", [account].flatten)
    }
    
    def self.find_by_author(author)
      where(author: author).first
    end

    def self.find_by_parent(parent_author)
      where(parent_author: parent_author).first
    end
    
    def self.find_by_author_and_permlink(author, permlink)
      where(author: author, permlink: permlink).first
    end
    
    def beneficiaries
      JSON[self[:beneficiaries]]
    end

    def tag_names
      tags.pluck(:tag)
    end
  end
end

# Strcture
#
# SteemApi::Comment(
#   ID: integer,
#   author: varchar,
#   permlink: varchar,
#   category: varchar,
#   parent_author: varchar,
#   parent_permlink: varchar,
#   title: text,
#   body: text,
#   json_metadata: text,
#   last_update: datetime,
#   created: datetime,
#   active: datetime,
#   last_payout: datetime,
#   depth: integer,
#   children: integer,
#   net_rshares: integer,
#   abs_rshares: integer,
#   vote_rshares: integer,
#   children_abs_rshares: integer,
#   cashout_time: datetime,
#   max_cashout_time: datetime,
#   total_vote_weight: float,
#   reward_weight: integer,
#   total_payout_value: money,
#   curator_payout_value: money,
#   author_rewards: money,
#   net_votes: integer,
#   root_comment: varchar,
#   mode: varchar,
#   max_accepted_payout: money,
#   percent_steem_dollars: integer,
#   allow_replies: boolean,
#   allow_votes: boolean,
#   allow_curation_rewards: boolean,
#   beneficiaries: varchar_max,
#   url: varchar_max,
#   root_title: text,
#   pending_payout_value: money,
#   total_pending_payout_value: money,
#   active_votes: varchar_max,
#   replies: varchar_max,
#   author_reputation: integer,
#   promoted: varchar,
#   body_length: integer,
#   reblogged_by: varchar_max,
#   body_language: varchar,
#   dirty: boolean,
#   TS: ss_timestamp
# )
