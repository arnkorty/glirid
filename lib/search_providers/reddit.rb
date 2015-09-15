module SearchProvider
  class Reddit < SearchProvider::Base
    def self.provider_name
      "Reddit Search"
    end

    kortype :query, type: String, required: true, desc: 'query keyword'
    kortype :limit, type: Integer, default: 100, desc: 'query limit'
    kortype :subreddit, type: String

    def run
      if self.subreddit.present?
        url = 'https://www.reddit.com/r/' + self.subreddit + '/search.json?q=' + self.query + '&limit=' + self.limit.to_s
      else
        url = 'https://www.reddit.com/search.json?q=' + self.query + '&limit=' + self.limit.to_s
      end
      search_results = get_json url
      results = []
      if search_results
        search_results['data']['children'].each do |result|
          result = {
            title: result['data']['title'],
            url: 'https://www.reddit.com' + result['data']['url'],
            domain: 'reddit.com',
            description: result['data']['selftext']
          }

          yield result

          results << result
        end
      end

      results
    end
  end
end
