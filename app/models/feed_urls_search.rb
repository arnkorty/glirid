class FeedUrlsSearch < ActiveRecord::Base
  belongs_to :feed_url
  belongs_to :search
end
