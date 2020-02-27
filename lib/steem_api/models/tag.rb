module SteemApi
  class Tag < SteemApi::SqlBase

    self.table_name = :Tags
    
    belongs_to :comment, foreign_key: 'comment_ID', class_name: 'SteemApi::Comment'
  end
end

# Structure
#
# SteemApi::Tag(
#   comment_ID integer,
#   tag varchar
# )
