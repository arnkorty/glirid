class FeedUrl < ActiveRecord::Base

  attr_accessor :search_ids

  belongs_to :account
  has_many :feed_urls_searches, dependent: :destroy
  # has_many :searches, through: :rss_feed_searches
  has_and_belongs_to_many :searches
  has_many :results, ->{ order(id: :desc) }, through: :searches

  after_save :set_searches

  scope :open, ->{ where(is_open: true).order(id: :desc) }

  def to_param
    "#{self.id} #{self.name}".to_url
  end

  private
  def set_searches
    if search_ids
      return unless Array === search_ids
      feed_urls_searches.where.not(search_id: search_ids).destroy_all
      search_ids.each do |search_id|
        feed_urls_searches.where(search_id: search_id).first_or_create
      end
    end
  end

  def set_token
    self.token = SecureRandom.hex(10) unless self.is_open
  end
end
