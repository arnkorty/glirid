Dir[Rails.root.join('lib/search_providers/*')].each do |path|
  Rails.configuration.cache_classes ? require(path) : load(path)
end
