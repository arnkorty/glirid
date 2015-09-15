# module SearchProvider
#   class Google < SearchProvider::Base
#     def self.provider_name
#       "Google Custom Search"
#     end
#     kortype :query, type: String, desc: 'query keyword', required: true
#     kortype :cx, type: String, required: true, \
#       desc: 'The custom search engine ID to scope this search query (string)'
#     kortype :google_developer_key, type: String, required: true
#     kortype :options, type: Hash, parse: ->(val){
#         begin
#           JSON.parse(val)
#         rescue
#           {}
#         end
#       }, desc: 'json format. input your options parameter. eg. {cr: "CN", num: 23}'
#
#     def run
#       current_page = 1
#       results =[]
#       opts = {
#         q: self.query,
#         cx: self.cx,
#         google_developer_key: self.google_developer_key
#       }.reverse_merge self.options
#       opts.select!{|k,v| v.present?}
#       url = "https://www.googleapis.com/customsearch/v1?" + opts.to_query
#       json = get_json(url)
#       while current_page <= [self.page_count, 1].max
#         res = get_response(url + "&page=#{current_page}")
#         search_results = JSON.parse(res)
#         break unless search_results['items']
#         current_page += 1
#         search_results['items'].each do |result|
#           result = {
#             title: result['name'],
#             url: result['html_url'],
#             domain: 'github.com',
#             description: result['description']
#           }
#           if block_given?
#             yield result
#           end
#           results << result
#         end
#       end
#       results
#     end
#   end
# end
