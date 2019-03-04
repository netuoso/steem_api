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
      scope :clear, -> { mode('') }
      
      scope :follower, lambda { |follower|
        blog.where("JSON_VALUE(json_metadata, '$[1].follower') = ?", follower)
      }
      
      scope :following, lambda { |following|
        blog.where("JSON_VALUE(json_metadata, '$[1].following') = ?", following)
      }
      
      scope :decorate_metadata, -> {
        previous_select = if all.select_values.none?
          Arel.star
        else
          all.select_values
        end
        
        r = select(previous_select)
        
        %w(follower following what).each do |key|
          r = r.select("JSON_VALUE(json_metadata, '$[1].#{key}') AS metadata_#{key}")
        end
        
        r
      }
    end
  end
end
