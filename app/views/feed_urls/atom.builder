atom_feed('xmlns:app' => 'http://www.w3.org/2007/app',
          'xmlns:openSearch' => 'http://a9.com/-/spec/opensearch/1.1/') do |feed|
  feed.title("#{@feed_url.name} | Glirid")
  feed.updated(Time.now)
  feed.tag!('openSearch:totalResults', @feed_url.limit)

  @feed_url.results.limit(@feed_url.limit).each do |result|
    feed.entry(result, url: result.abs_url) do |entry|
      entry.title(result.title)
      entry.content(result.description, type: 'html')
      #  entry.link(href: result.url, rel: 'hub')
      entry.tag!('app:edited', result.updated_at)
      #  entry.url(result.url)

      entry.author do |author|
        author.name(result.domain)
      end
    end
  end
end
