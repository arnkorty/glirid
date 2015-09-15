require Rails.join('lib/search_providers/_base').to_s
Dir[Rails.root.join('lib/search_providers/*')].each do |path|
  Rails.configuration.cache_classes ? require(path) : load(path)
end
