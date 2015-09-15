module ApplicationHelper
  def url_by_feed(feed, flag = :rss)
    opt = {}
    unless feed.is_open
      opt[:token] = feed.token
    end
    if flag.to_sym == :rss
      rss_feed_url_url(feed, opt)
    else
      atom_feed_url_url(feed, opt)
    end
  end
end
