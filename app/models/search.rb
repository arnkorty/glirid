class Search < ActiveRecord::Base
  acts_as_paranoid

  serialize :options, HashSerializer

  PROVIDERS = SearchProvider::Base.descendants.map{|s| [s.provider_name, s.to_s]}

  belongs_to :account
  has_many :search_tasks
  has_many :results
  has_many :feed_urls_searches
  has_and_belongs_to_many :feed_urls

  validates :name, :account_id, presence: true
  validates :provider, presence: true, inclusion: {in: PROVIDERS.map(&:last)}
  validates_with ProviderValidator

  after_initialize do |search|
    if search.new_record?
      search.provider ||= PROVIDERS[0][1]
    end
  end

  def provider_class
    self.provider.constantize
  end

  def provider_instance
    @provider_instance ||= provider_class.new(self.options)
  end

  def run
    provider_instance.run{|raw_result|
      result = self.results.where(url: raw_result[:url]).first_or_initialize
      result.update_attributes raw_result
    }
  end

  def current_status
    if self.current_work_id
      JobStatus.new(self.current_work_id).try(:status)
    end
  end
end
