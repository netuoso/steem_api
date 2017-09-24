module SteemApi
  class Token < SteemApi::SqlBase

  self.table_name = :Tokens

  scope :before, lambda { |before, field = 'time'| where("#{field} < ?", before) }
  scope :after, lambda { |after, field = 'time'| where("#{field} > ?", after) }
  scope :today, -> { after(1.day.ago) }
  scope :yesterday, -> { before(1.day.ago).after(2.days.ago) }
  
  end
end

# Structure
#
# SteemApi::Token(
#   id: integer,
#   hour: boolean,
#   symbol: varchar,
#   time: smalldatetime,
#   open: real,
#   close: real,
#   high: real,
#   low: real,
#   volumefrom: real,
#   volumeto: real
# )
