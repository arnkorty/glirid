class ProviderValidator < ActiveModel::Validator
  def validate(record)
    record.provider_class.kortype_columns.values.each do |col|
      if col.options[:required] && record.options[col.name].blank?
        record.errors.add col.name, "#{col.name} is required"
      end
      if col.options[:enums] && !col.options[:enums].include?(record.options[col.name])
        record.errors.add col.name, "#{col.name} is invalid"
      end
      if col.options[:validate] && Proc === col.options[:validate]
        unless col.options[:validate].call(record.options[col.name])
          record.errors.add col.name, "#{col.name} is invalid"
        end
      end
    end
  end
end
