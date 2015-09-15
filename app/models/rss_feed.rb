class RssFeed < ActiveRecord::Base
  attr_accessor :search_ids

  belongs_to :account
  has_many :rss_feed_searches
  has_many :searches, through: :rss_feed_searches
  has_many :results, ->{ order(id: :desc) }, through: :searches

  after_save :set_searches

  def to_param
    "#{self.id} #{self.name}".to_url
  end

  private
  def set_searches
    if search_ids
      return unless Array === search_ids
      rss_feed_searches.where.not(search_id: search_ids).destroy_all
      search_ids.each do |search_id|
        rss_feed_searches.where(search_id: search_id).first_or_create
      end
    end
  end
end