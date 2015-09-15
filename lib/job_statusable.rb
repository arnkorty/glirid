class JobStatusable < ActiveJob::Base
  queue_as :glirid

  after_enqueue do |job|
    JobStatus.set_status(job.job_id, :queued)
  end
  #
  before_enqueue do |job|
    # JobStatus.set_status(job.job_id, :enqueued)
    # Rails.logger.info 'before_enqueue'
  end
  #
  before_perform do |job|
    JobStatus.set_status(job.job_id, :working)
    search = Search.find_by(current_work_id: job.job_id)
    if search
      search.update_columns last_at: Time.now
    end
  end

  after_perform do |job|
    JobStatus.set_status(job.job_id, :complete)
    search = Search.find_by(current_work_id: job.job_id)
    if search
      search.update_columns last_at: Time.now
    end
  end
end
