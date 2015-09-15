class Result < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :search
  belongs_to :account

  validates :search_id, :account_id, presence: true
  validates_uniqueness_of :url, scope: :search_id

  before_validation :set_account

  delegate :provider, to: :search
  alias_attribute :name, :title

  include PgSearch
  pg_search_scope :search_full_text, against: {
                    title: 'A',
                    description: 'B'
                  }, associated_against: {
                    search: [:provider, :name]
                  }, using: {
                    :tsearch => { dictionary: 'scws_parser'}
                  }


  private
  def set_account
    if !self.account && self.search
      self.account = self.search.account
    end
  end
end
