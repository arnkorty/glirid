class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :results
  has_many :searches
  has_many :feed_urls
  has_many :search_tasks

  before_create :set_rss_token

  def admin?
    self.admin
  end

  private
  def set_rss_token
    self.rss_token = SecureRandom.hex 20
  end
end
