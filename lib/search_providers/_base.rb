require 'uri'
require 'net/http'
require 'json'
module  SearchProvider
  class Base
    include Kortype
    def self.provider_name
      fail 'Please set provider name!'
    end

    def self.options
    end

    def get_response(url)
      uri = URI URI.escape(url)
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Get.new(uri.request_uri)
      if url.start_with?('https')
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      if response.code =~ /^3/ && @try_time > 0 && response['location']
        get_response response['location']
      elsif response.code == '200'
        response.body
      end
      # response.status
    end

    def get_json(url)
      res = get_response url
      JSON.parse res if res
    end

    def initialize(options = {})
      @try_time = 3
      kortype_columns.each do |key, col|
        col.value = options[key]
      end
    end

    def run
      fail 'Please set run method'
    end
  end
end
