xml.instruct! :xml, version: '1.0'
xml.rss(version: '2.0'){
  xml.channel{
    xml.title "#{@rss_feed.name} | #{Rails.application.secrets.app_name}"
    xml.link root_url
    xml.description @rss_feed.description
    xml.language 'en-us'
    xml.lastBuildDate Time.now.strftime("%a, %d %b %Y %H:%M:%S %z")
    xml.pubDate @rss_feed.created_at.strftime("%a, %d %b %Y %H:%M:%S %z")
    @rss_feed.results.limit(@rss_feed.limit || 100).each do |result|
      xml.item do
        xml.title result.title
        xml.description raw(result.description)
        xml.author result.domain
        xml.pubDate result.created_at.strftime("%a, %d %b %Y %H:%M:%S %z")
        xml.link result.url
        xml.guid result.url
      end
    end
  }
}
