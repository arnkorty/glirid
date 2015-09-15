xml.instruct! :xml, version: '1.0'
xml.rss(version: '2.0') do
  xml.channel do
    xml.title "#{@feed_url.name} | #{Rails.application.secrets.app_name}"
    xml.link root_url
    xml.description @feed_url.description
    xml.language 'en-us'
    xml.lastBuildDate Time.now.strftime('%a, %d %b %Y %H:%M:%S %z')
    xml.pubDate @feed_url.created_at.strftime('%a, %d %b %Y %H:%M:%S %z')
    @feed_url.results.limit(@feed_url.limit || 100).each do |result|
      xml.item do
        xml.title result.title
        xml.description raw(result.description)
        xml.author result.domain
        xml.pubDate result.created_at.strftime('%a, %d %b %Y %H:%M:%S %z')
        xml.link result.url
        xml.guid result.url
      end
    end
  end
end
