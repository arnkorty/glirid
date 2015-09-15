require 'rss'
module SearchProvider
  class Atom < SearchProvider::Base
    def self.provider_name
      'Atom Search'
    end
    kortype :feed_url, type: String, required: true, desc: 'Your Feed URL'
    kortype :query, type: String, desc: 'query keyword'

    def run
      results = []

      domain = URI.parse(feed_url).try(:host) || 'Unknown'
      regex = Regexp.union(self.query.split(',').map(&:strip).map {
        |re| Regexp.new(re, Regexp::IGNORECASE) }) if self.query.present?
      rss = get_response feed_url
      if rss
        feed = ::RSS::Parser.parse(rss)
        feed_title = "#{feed.try(:channel).try(:title) || feed.try(:title)}"
        feed.items.reverse.each do |result|
          skip_next = false
          if regex &&
            !(result.try(:title).to_s.match(regex) ||
              result.try(:description).to_s.match(regex) ||
              result.try(:content).to_s.match(regex))

            skip_next = true
          end
          next if skip_next
          result = {
              title: "#{ActionView::Base.full_sanitizer.sanitize(feed_title.to_s)}: #{ActionView::Base.full_sanitizer.sanitize(result.title.to_s)}",
              url: result.try(:link).try(:href) || result.try(:link).to_s,
              description: result.try(:description),
              domain: domain
            }

          if block_given?
            yield result
          end

          results << result
        end
      end
    end
  end
end
