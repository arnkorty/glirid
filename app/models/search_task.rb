class SearchTask < ActiveRecord::Base
  belongs_to :search
  belongs_to :frequency
  belongs_to :search

  delegate :name, to: :frequency, prefix: true, allow_nil: true
  delegate :name, to: :search, prefix: true, allow_nil: true
  delegate :frequency_time, to: :frequency, allow_nil: true

  def next_at
    if frequency_time && frequency_time > 0
      Time.now + frequency_time - ((Time.current - self.begin_at) % frequency_time)
    end
  end
end
