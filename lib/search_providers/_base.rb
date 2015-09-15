require 'uri'
require 'net/http'
require 'json'
module  SearchProvider
  class Base
    include Kortype
    def self.provider_name
      raise 'Please set provider name!'
    end

    def self.options
    end

    def get_response url
      url = URI.escape url
      response = Net::HTTP.get_response URI(url)
      if response.code == '200'
        response.body
      end
    end

    def get_json url
      res = get_response url
      if res
        JSON.parse res
      end
    end

    def initialize options = {}
      kortype_columns.each do |key, col|
        col.value = options[key]
      end
    end

    def run
      raise 'Please set run method'
    end

    def stop
    end

    def start
    end
    def update
    end
  end
end
