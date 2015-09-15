class RssFeedSearch < ActiveRecord::Base
  belongs_to :rss_feed
  belongs_to :search
end
