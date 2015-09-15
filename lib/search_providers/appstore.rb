require 'json'
module SearchProvider
  class Appstore < SearchProvider::Base
    def self.provider_name
      'Apple Store Search'
    end
    
    kortype :query, type: String, desc: 'define your search keyword', required: true
    kortype :limit, type: Integer, desc: 'define your query limit'
    kortype :match_all, type: String, enums: ['Yes', 'No'], desc: 'Is match all?',\
      default: false, required: true

    def run
      url = 'https://itunes.apple.com/search?media=software&term=' + self.query + '&limit=' + self.limit.to_s
      res = get_response url
      results = []
      if res
        search_results = JSON.parse res
        search_results['results'].each do |result|
          skiq_result = false
          if self.match_all
            self.query.split(' ').each do |term|
              if !result.to_s.include?(term)
                skiq_result = true
                break
              end
            end
          end

          next if skiq_result

          result = {
            title: result['trackName'],
            url: result['trackViewUrl'],
            domain: 'itunes.apple.com',
            description: result['description']
          }
          if block_given?
            yield result
          end
          results << result
        end
      end
      results
    end
  end
end
