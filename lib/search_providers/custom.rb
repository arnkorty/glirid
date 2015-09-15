require 'nokogiri'
module SearchProvider
  class Custom < SearchProvider::Base
    def self.provider_name
      'Custom Search'
    end
    kortype :custom_type, type: String, enums: ['HTML', 'XML'], required: true,\
      default: 'HTML', desc: 'define your custom type'
    kortype :url, type: String, required: true, desc: 'Your URL'
    kortype :item_selector, type: String, desc: 'Your item css selector', required: true
    kortype :title_selector, type: String, required: true, desc: 'Your title css selector'
    kortype :href_selector, type: String, required: true, desc: 'Your href css selector'
    kortype :description_selector, type: String, desc: 'Your description css selector'

    def run
      results = []
      res = get_response self.url
      if res
        if self.custom_type == 'XML'
          doc = Nokogiri::XML(res)
        else
          doc = Nokogiri::HTML(res)
        end
        doc.css(self.item_selector).reverse.each do |item|
          result = {}
          result[:title] = item.css(self.title_selector).text.strip
          result[:url]  = item.css(self.href_selector).first.try(:attr, 'href')
          result[:description] = item.css(self.description_selector).text if self.description_selector.present?
          next if result[:title].blank? || result[:url].blank?
          result[:domain] = URI.parse(result[:url]).host || URI.parse(self.url).host
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
