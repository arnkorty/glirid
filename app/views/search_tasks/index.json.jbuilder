json.array!(@search_tasks) do |search_task|
  json.extract! search_task, :id, :search_id, :frequency, :begin_at
  json.url search_task_url(search_task, format: :json)
end
