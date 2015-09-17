class SearchTaskJob < JobStatusable
  def perform(task_id)
    task = SearchTask.find task_id
    task.search.sync_run
    if task.frequency.frequency_time > 0
      SearchTaskJob.set(wait: task.frequency.frequency_time).perform_later task_id
    end
  end
end
