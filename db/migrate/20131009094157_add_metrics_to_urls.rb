class AddMetricsToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :internal_links, :integer
    add_column :urls, :external_links, :integer
  end
end
