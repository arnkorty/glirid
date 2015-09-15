json.array!(@searches) do |search|
  json.extract! search, :id, :keyword, :provider
  json.url search_url(search, format: :json)
end
