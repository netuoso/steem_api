module SteemApi
  module Tx
    class AccountWitnessProxy < SteemApi::SqlBase

      self.table_name = :TxAccountWitnessProxies
      
      scope :active, lambda { |account = nil|
        active = all
        active = active.where(proxy: account) if !!account
        
        ids = active.map do |p|
          p.id unless AccountWitnessProxy.where(account: p.account).
            where.not(proxy: p.Proxy).
            where('timestamp > ?', p.timestamp).exists?
        end
        
        where(id: ids)
      }
    end
  end
end

# Structure
#
# SteemApi::Tx::AccountWitnessProxy(
#   ID: integer,
#   tx_id: integer,
#   account: varchar,
#   Proxy: varchar,
#   timestamp: datetime
# )
