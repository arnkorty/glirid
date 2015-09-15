require 'json'
module SearchProvider
  class Github < SearchProvider::Base
    def self.provider_name
      "Github Repositories Search"
    end
    kortype :query, type: String, desc: 'query keyword', required: true
    kortype :sort, type: String, desc: 'search sort'
    kortype :order, type: String, desc: 'search order'
    kortype :page_count, type: Integer, default: 1, desc: 'define page total number'

    def run
      current_page = 1
      results =[]
      url = "https://api.github.com/search/repositories?q=#{self.query}&sort=#{self.sort}&order=#{self.order}"
      while current_page <= [self.page_count, 1].max
        res = get_response(url + "&page=#{current_page}")
        search_results = JSON.parse(res)
        break unless search_results['items']
        current_page += 1
        search_results['items'].reverse.each do |result|
          result = {
            title: result['name'],
            url: result['html_url'],
            domain: 'github.com',
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
