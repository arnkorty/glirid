class SearchJob < JobStatusable
  def perform(id)
    search = Search.find id
    search.run
  end
end
