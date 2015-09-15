module SearchesHelper
  def render_provider_form(provider, field, options = {})
    provider.kortype_columns.values.map{|col|
      if col.options[:enums]
        field.input col.name, collection: col.options[:enums], include_blank: false,\
          selected: options[col.name] || col.default, required: !!col.options[:required]
      else
        field.input col.name, input_html: {value: options[col.name] || col.default}, \
          required: !!col.options[:required], placeholder: col.options[:desc] || col.name
      end
    }.join
  end
end
