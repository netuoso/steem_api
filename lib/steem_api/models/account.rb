module SteemApi
  class Account < SteemApi::SqlBase

    self.table_name = :Accounts

    scope :before, lambda { |before, field = 'created'| where("#{field} < ?", before) }
    scope :after, lambda { |after, field = 'created'| where("#{field} > ?", after) }
    scope :today, -> { after(1.day.ago) }
    scope :yesterday, -> { before(1.day.ago).after(2.days.ago) }
    
    def witness?
      self.witness_votes != "[]"
    end
    
    def proxied_vsf_votes_total
      JSON[proxied_vsf_votes].map(&:to_i).sum
    end
  end
end

# Structure
#
# SteemApi::Account(
#   id: varchar,
#   name: varchar,
#   owner: varchar_max,
#   active: varchar_max,
#   posting: varchar_max,
#   memo_key: varchar_max,
#   json_metadata: text,
#   proxy: varchar,
#   last_owner_update: datetime,
#   last_account_update: datetime,
#   created: datetime,
#   mined: boolean,
#   owner_challenged: boolean,
#   active_challenged: boolean,
#   last_owner_proved: datetime,
#   last_active_proved: datetime,
#   recovery_account: varchar,
#   last_account_recovery: datetime,
#   reset_account: varchar,
#   comment_count: integer,
#   lifetime_vote_count: integer,
#   post_count: integer,
#   can_vote: boolean,
#   voting_power: integer,
#   last_vote_time: datetime,
#   balance: varchar,
#   savings_balance: varchar,
#   sbd_balance: varchar,
#   sbd_seconds: integer,
#   sbd_seconds_last_update: datetime,
#   sbd_last_interest_payment: datetime,
#   savings_sbd_balance: varchar,
#   savings_sbd_seconds: integer,
#   savings_sbd_seconds_last_update: datetime,
#   savings_sbd_last_interest_payment: datetime,
#   savings_withdraw_requests: integer,
#   vesting_shares: varchar,
#   vesting_withdraw_rate: varchar,
#   next_vesting_withdrawal: datetime,
#   withdrawn: integer,
#   to_withdraw: integer,
#   withdraw_routes: integer,
#   curation_rewards: integer,
#   posting_rewards: integer,
#   proxied_vsf_votes: varchar_max,
#   witnesses_voted_for: integer,
#   average_bandwidth: integer,
#   lifetime_bandwidth: integer,
#   last_bandwidth_update: datetime,
#   average_market_bandwidth: integer,
#   last_market_bandwidth_update: datetime,
#   last_post: datetime,
#   last_root_post: datetime,
#   vesting_balance: varchar,
#   reputation: integer,
#   transfer_history: varchar_max,
#   market_history: varchar_max,
#   post_history: varchar_max,
#   vote_history: varchar_max,
#   other_history: varchar_max,
#   witness_votes: varchar_max,
#   dirty: boolean,
#   TS: ss_timestamp
# )
