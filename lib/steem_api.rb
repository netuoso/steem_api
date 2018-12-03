require "steem_api/version"

# Top Level Models
require "steem_api/models/sql_base"
require "steem_api/models/account"
require "steem_api/models/block"
require "steem_api/models/comment"
require "steem_api/models/connection"
require "steem_api/models/dynamic_global_properties"
require "steem_api/models/follower"
require "steem_api/models/reblog"
require "steem_api/models/token"
require "steem_api/models/transaction"
require "steem_api/models/witness"

# Sub Level Models
require "steem_api/models/tx/account_create"
require "steem_api/models/tx/account_recover"
require "steem_api/models/tx/account_witness_proxy"
require "steem_api/models/tx/account_witness_vote"
require "steem_api/models/tx/claim_reward_balance"
require "steem_api/models/tx/comment"
require "steem_api/models/tx/comments_option"
require "steem_api/models/tx/convert"
require "steem_api/models/tx/custom"
require "steem_api/models/tx/delegate_vesting_share"
require "steem_api/models/tx/delete_comment"
require "steem_api/models/tx/escrow_approve"
require "steem_api/models/tx/escrow_dispute"
require "steem_api/models/tx/escrow_release"
require "steem_api/models/tx/escrow_transfer"
require "steem_api/models/tx/feed"
require "steem_api/models/tx/limit_order"
require "steem_api/models/tx/pow"
require "steem_api/models/tx/transfer"
require "steem_api/models/tx/vote"
require "steem_api/models/tx/withdraw"
require "steem_api/models/tx/withdraw_vesting_route"
require "steem_api/models/tx/witness_update"

require "steem_api/models/tx/custom/follow"
require "steem_api/models/tx/custom/witness"
require "steem_api/models/tx/custom/reblog"

require "steem_api/models/vo/author_reward"
require "steem_api/models/vo/comment_benefactor_reward"
require "steem_api/models/vo/curation_reward"
require "steem_api/models/vo/fill_convert_request"
require "steem_api/models/vo/fill_order"
require "steem_api/models/vo/fill_transfer_from_savings"
require "steem_api/models/vo/fill_vesting_withdraw"
require "steem_api/models/vo/interest"
require "steem_api/models/vo/liquidity_reward"
require "steem_api/models/vo/producer_reward"
require "steem_api/models/vo/return_vesting_delegation"
require "steem_api/models/vo/shutdown_witness"

module SteemApi
end

# Monkeypatch to implement: https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/issues/274#issuecomment-167578393
# Copied from: https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/blob/d4b6e4134e15d8d73be48ad6d8da1911f7001d9e/lib/active_record/connection_adapters/sqlserver/schema_statements.rb
# Switched "sp_helptext" from above (#view_information) to use "sp_columns"
module ActiveRecord
  module ConnectionAdapters
    module SQLServer
      module SchemaStatements
        def view_information(table_name)
          @view_information ||= {}
          @view_information[table_name] ||= begin
            identifier = SQLServer::Utils.extract_identifiers(table_name)
            view_info = select_one "SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = #{quote(identifier.object)}", 'SCHEMA'
            if view_info
              view_info = view_info.with_indifferent_access
              if view_info[:VIEW_DEFINITION].blank? || view_info[:VIEW_DEFINITION].length == 4000
                view_info[:VIEW_DEFINITION] = begin
                  select_values("EXEC sp_columns #{identifier.object_quoted}", 'SCHEMA').join
                rescue
                  warn "No view definition found, possible permissions problem.\nPlease run GRANT VIEW DEFINITION TO your_user;"
                  nil
                end
              end
            end
            view_info
          end
        end
      end
    end
  end
end
