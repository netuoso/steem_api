module SteemApi
  module Tx
    class Custom::Community < SteemApi::Tx::Custom
      default_scope { where(tid: :community) }
      
      scope :normalized_json, -> { where("ISJSON(json_metadata) > 0") }
      scope :op, lambda { |op| normalized_json.where("JSON_VALUE(json_metadata, '$[0]') = ?", op) }
      scope :community, lambda { |community| normalized_json.where("JSON_VALUE(json_metadata, '$[1].community') = ?", community) }
      scope :role, lambda { |role| normalized_json.where("JSON_VALUE(json_metadata, '$[1].role') = ?", role) }
      scope :language, lambda { |language| normalized_json.where("JSON_VALUE(json_metadata, '$[1].language') = ?", language) }
      scope :nsfw, lambda { |nsfw = true| normalized_json.where("JSON_VALUE(json_metadata, '$[1].is_nsfw') = ?", nsfw) }
      scope :account, lambda { |account|
        account = [account].flatten
        normalized_json.where("required_auth IN(?) OR required_posting_auth IN(?) OR JSON_VALUE(json_metadata, '$[1].account') IN(?)", account, account, account)
      }
      scope :permlink, lambda { |permlink|
        normalized_json.where("JSON_VALUE(json_metadata, '$[1].permlink') = ?", permlink)
      }
      scope :slug, lambda { |slug|
        normalized_json.where("JSON_VALUE(json_metadata, '$[1].account') = ? AND JSON_VALUE(json_metadata, '$[1].permlink') = ?", *slug.split('/'))
      }
      
      def self.ops
        distinct.normalized_json.pluck(Arel.sql "JSON_VALUE(json_metadata, '$[0]') AS ops")
      end
      
      def payload
        JSON[json_metadata][1] rescue nil
      end
    end
  end
end
