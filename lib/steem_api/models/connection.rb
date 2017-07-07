require 'rest-client'
require 'nokogiri'

module SteemApi
  class Connection < SteemApi::SqlBase

    self.table_name = nil

    def self.steem_per_mvests
      begin
        # SteemDollar.com (fastest)
        steemdollar_response = RestClient::Request.execute(method: :get, url: "https://www.steemdollar.com/vests.php", timeout: 3, open_timeout: 3).body
        Nokogiri::XML.parse(steemdollar_response).css('.text-intro')[2].text.match(/1\s*VESTS\s*=\s*(\d*\.\d*)/)[1]

        # Steemd.com
        # steemd_response = RestClient::Request.execute(method: :get, url: "https://steemd.com", timeout: 3, open_timeout: 3).body
        # Nokogiri::XML.parse(steemd_response).css('.hash3').first.text.match(/^steem_per_mvests(\d*.\d*)/)[1]
      rescue => e
        Rails.logger.error("Error: #{e}")
        Settings.steem_per_mvests
      end
    end

    def self.tables
      self.connection.tables
    end

    def self.columns(model_name)
      "SteemApi::#{model_name}".constantize.columns.map(&:name)
    end

  end
end
