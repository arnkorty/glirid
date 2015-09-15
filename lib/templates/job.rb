<% module_namespacing do -%>
class <%= class_name %>Job <  JobStatusable
  def perform(*args)
    # Do something later
  end
end
<% end -%>
