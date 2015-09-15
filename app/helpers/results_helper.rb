module ResultsHelper
  def render_filter_sort col, records = []
      sort_class = 'fa-sort-down'
    if params[:sort] && params[:sort].include?(col)
      if params[:sort].include? 'asc'
        sort_class = 'fa-sort-up'
      end
    end
    html = content_tag(:span, data: {dropdown: "sort-#{col.sub('.', '')}"}) do
      content_tag(:i, nil, class: "fa #{sort_class}")
    end.concat(content_tag(:ul, id: "sort-#{col.sub('.', '')}", class: 'f-dropdown') do
      ([
        ['sort', "#{col}.asc", 'ASC'],
        ['sort', "#{col}.desc", 'DESC']
      ] + records.map{|record| ['filter', "#{col}-#{record}", record]}).map{|s|
        content_tag(:li) do
          opt = params.slice(:query, :sort, :filter).merge(s[0] => s[1])
          link_to s.last, url_for(opt)
        end
      }.join.html_safe
    end)
    html
  end
end
