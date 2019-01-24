module SteemApi
  class Transaction < SteemApi::SqlBase

    self.table_name = :Transactions
    self.primary_key = :tx_id
    
    belongs_to :block, foreign_key: :block_num
    has_many :block_transactions, through: :block, source: :transactions

    scope :before, lambda { |before, field = 'expiration'| where("#{field} < ?", before) }
    scope :after, lambda { |after, field = 'expiration'| where("#{field} > ?", after) }
    scope :today, -> { after(1.day.ago) }
    scope :yesterday, -> { before(1.day.ago).after(2.days.ago) }
    
    scope :type, lambda { |type| where(type: type) }
    
    # So you have a Transaction#tx_id and you want to know what the operation was
    # that lead to it.  Well, that's tricky because all of the ops are in their
    # own tables.  This method will (slowly) try to find the appropriate table.
    def op
      retries = 0
      puts type
      # Here, we map the type to class name, if supported.  Most of them can be
      # mapped automatically, e.g. "vote" => "Vote" but some types share tables
      # with one another.  We also use timestamps to narrow the search
      # parameters, for all the good it does.  We use the expiration minus the
      # maximum TaPoS window.
      op_type = case type
      when 'account_create_with_delegation', 'create_claimed_account' then 'AccountCreate'
      when 'comment_options' then 'CommentOption'
      when 'custom_json' then 'Custom'
      when 'delegate_vesting_shares' then 'DelegateVestingShare'
      when 'feed_publish' then 'Feed'
      when 'limit_order_create', 'limit_order_create2' then 'LimitOrder'
      when 'Pow2' then 'Pow'
      when 'set_withdraw_vesting_route' then 'WithdrawVestingRoute'
      when 'transfer_from_savings', 'transfer_to_vesting' then 'Transfer'
      when 'withdraw_vesting' then 'Withdraw'
      when *%w(
        cancel_transfer_from_savings change_recovery_account claim_account
        decline_voting_rights limit_order_cancel recover_account
        request_account_recovery witness_set_properties
      ) then raise "Unsupported: #{type}"
      else; type.split('_').collect(&:capitalize).join
      end
      
      tapos_window_start = expiration - 28800.seconds
      ops = Tx.const_get(op_type).where(tx_id: self).
        where("timestamp BETWEEN ? AND ?", tapos_window_start, expiration)
      
      loop do
        retries += 1
        op = ops.first
        
        return op if !!op
        break if retries > 10
        
        sleep 3
      end
      
      raise "Unable to find #{type} for tx_id: #{tx_id}"
    end
  end
end

# Structure
#
# SteemApi::Transaction(
#   tx_id: integer,
#   block_num: integer,
#   transaction_num: integer,
#   ref_block_num: integer,
#   ref_block_prefix: integer,
#   expiration: datetime,
#   type: varchar
# )
