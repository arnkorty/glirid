class EnableScwsParser < ActiveRecord::Migration
  def change
    enable_extension "scws_parser"
  end
end
