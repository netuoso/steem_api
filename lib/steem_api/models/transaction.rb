module SteemApi
  class Transaction < SteemApi::SqlBase

    self.table_name = :Transactions
    self.primary_key = :tx_id

    def block
      SteemApi::Block.find(block_num)
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
