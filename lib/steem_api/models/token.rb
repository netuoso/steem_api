module SteemApi
  class Token < SteemApi::SqlBase

  self.table_name = :Tokens

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
