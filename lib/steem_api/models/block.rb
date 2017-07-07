module SteemApi
  class Block < SteemApi::SqlBase

    self.table_name = :Blocks
    self.primary_key = :block_num

  end
end

# Structure
#
# SteemApi::Block(
#   block_num: integer,
#   previous: varchar,
#   timestamp: datetime,
#   witness: varchar,
#   witness_signature: varchar,
#   transaction_merkle_root: varchar
# )
