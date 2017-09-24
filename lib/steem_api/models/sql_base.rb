require "active_record"

module SteemApi
  class SqlBase < ActiveRecord::Base

    establish_connection({
      adapter: "sqlserver",
      host: "sql.steemsql.com",
      username: "steemit",
      password: "steemit",
      timeout: 60
    })

    self.table_name = nil
    self.inheritance_column = nil
    self.abstract_class = true

    scope :before, lambda { |before, field = 'timestamp'| where("#{field} < ?", before) }
    scope :after, lambda { |after, field = 'timestamp'| where("#{field} > ?", after) }
    scope :today, -> { after(1.day.ago) }
    scope :yesterday, -> { before(1.day.ago).after(2.days.ago) }
    
    def tx
      SteemApi::Transaction.find_by(tx_id: self.tx_id)
    end

  end
end