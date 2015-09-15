class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :results
  has_many :searches
  has_many :feed_urls
  has_many :search_tasks, through: :searches

  validates :email,
    :presence => true, format: {with: email_regexp}
  validates_uniqueness_of :email, scope: :deleted_at, unless: :deleted?

  before_create :set_rss_token

  def admin?
    self.admin
  end

  # overwrite devise email validation
  def email_changed?
    false
  end

  private
  def set_rss_token
    self.rss_token = SecureRandom.hex 20
  end
end
