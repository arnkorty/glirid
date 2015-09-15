json.array!(@results) do |result|
  json.extract! result, :id, :search_id, :account_id, :title, :url, :domain, :description, :task_at
  json.url result_url(result, format: :json)
end
