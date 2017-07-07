module SteemApi
  module Vo
    class ShutdownWitness < SteemApi::SqlBase

      self.table_name = :VOShutdownWitnesses

    end
  end
end

# Structure
#
# SteemApi::Vo::ShutdownWitness(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   owner: varchar
# )
