module SteemApi
  module Tx
    class Custom::Follow < SteemApi::Tx::Custom
      default_scope {
        where(tid: :follow).
        where("JSON_VALUE(json_metadata, '$[0]') = 'follow'")
      }
      
      scope :mode, lambda { |mode, options = {invert: false}|
        invert = options[:invert] || false
        
        if invert
          where("JSON_VALUE(json_metadata, '$[1].what[0]') <> ?", mode)
        else
          where("JSON_VALUE(json_metadata, '$[1].what[0]') = ?", mode)
        end
      }
      
      scope :blog, -> { mode('blog') }
      scope :ignore, -> { mode('ignore') }
      scope :reset, -> { mode('') }
      
      scope :follower, lambda { |follower|
        blog.where("JSON_VALUE(json_metadata, '$[1].follower') = ?", follower)
      }
      
      scope :following, lambda { |following|
        blog.where("JSON_VALUE(json_metadata, '$[1].following') = ?", following)
      }
    end
  end
end
