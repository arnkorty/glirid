require 'nokogiri'
module SearchProvider
  class Custom < SearchProvider::Base
    def self.provider_name
      'Custom Search'
    end
    kortype :custom_type, type: String, enums: ['HTML', 'XML'], required: true,\
      default: 'HTML', desc: 'define your custom type'
    kortype :url, type: String, required: true, desc: 'Your URL'
    kortype :item_selector, type: String, validate: ->(v){
      v =~ /\A\S.+\S\Z/
    }, desc: 'Your item css selector', required: true
    kortype :title_selector, type: String, required: true, validate: ->(v){
      v =~ /\A\S.+\S\Z/
    }, desc: 'Your title css selector'
    kortype :href_selector, type: String, required: true, validate: ->(v){
      v =~ /\A\S.+\S\Z/
    }, desc: 'Your href css selector'
    kortype :description_selector, type: String, validate: ->(v){
      v =~ /\A\S.+\S\Z/
    }, desc: 'Your description css selector'

    def run
      results = []
      res = get_response self.url
      if res
        if self.custom_type == 'XML'
          doc = Nokogiri::XML(res)
        else
          doc = Nokogiri::HTML(res)
        end
        doc.css(self.item_selector).each do |item|
          result = {}
          result[:title] = item.css(self.title_selector).text.strip
          result[:href]  = item.css(self.href_selector).first.try(:attr, 'href')
          result[:description] = item.css(self.description).text
          next if result[:title].blank? || result[:href].blank?
          result[:domain] = URI.parse(result[:href]).host
          if block_given?
            yield result
          end
          results << result
        end
      end

      results
    end
  end
end
