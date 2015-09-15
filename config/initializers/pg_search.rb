module PgSearch
  class ScopeOptions
    def sanitize_sql_array(array)
      @model.send(:sanitize_sql_array, array)
    end
  end
end
