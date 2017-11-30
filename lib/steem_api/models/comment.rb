module SteemApi
  class Comment < SteemApi::SqlBase

    self.table_name = :Comments
    
    scope :before, lambda { |before, field = 'created'| where("#{field} < ?", before) }
    scope :after, lambda { |after, field = 'created'| where("#{field} > ?", after) }
    scope :today, -> { after(1.day.ago) }
    scope :yesterday, -> { before(1.day.ago).after(2.days.ago) }
    
    scope :normalized_json, -> { where("json_metadata LIKE '{%}'") }
    
    scope :app, lambda { |app|
      normalized_json.where("JSON_VALUE(json_metadata, '$.app') LIKE ?", "#{app}/%")
    }
    
    def self.find_by_author(user)
      self.where(author: user)
    end

    def self.find_by_parent(user)
      self.where(parent_author: user)
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
