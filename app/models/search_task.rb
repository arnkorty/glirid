class SearchTask < ActiveRecord::Base
  belongs_to :search
  belongs_to :frequency
  # belongs_to :account, through: :search

  delegate :name, to: :frequency, prefix: true, allow_nil: true
  delegate :name, to: :search, prefix: true, allow_nil: true
  delegate :frequency_time, to: :frequency, allow_nil: true

  after_create :set_task_job
  # before_save :set_task_job

  def next_at
    if frequency_time && frequency_time > 0
      Time.now + frequency_time - ((Time.current - self.begin_at) % frequency_time)
    end
  end

  private
  def set_task_job(time = nil)
    if time
      job = SearchTaskJob.set(wait_until: time).perform_later self.id
    else
      job = SearchTaskJob.set(wait_until: self.next_at).perform_later self.id
    end
    self.update_columns job_id: job.job_id
  end
end
