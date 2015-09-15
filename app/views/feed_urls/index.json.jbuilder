json.array!(@feed_urls) do |feed_url|
  json.extract! feed_url, :id, :name, :description, :account_id, :token
  json.url feed_url_url(feed_url, format: :json)
end
