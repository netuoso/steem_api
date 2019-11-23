module SteemApi
  module Vo
    class ProposalPay < SteemApi::SqlBase

      self.table_name = :VOProposalPay

    end
  end
end

# Structure
#
# SteemApi::Vo::ProposalPay(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   payment: money,
#   trx_id: varchar,
#   op_in_trx: integer
# )
