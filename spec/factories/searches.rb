FactoryGirl.define do
  factory :search do
    account
    provider 'SearchProvider::GitHub'
    name 'github search'
    description 'github search'
    options query: 'github search'
    trait :github do
      provider 'SearchProvider::Github'
      options query: 'ruby'
    end

    trait :rss do
      provider 'SearchProvider::RSS'
      options feed_url: 'https://ruby-china.org/topics/feed'
    end
  end
end
