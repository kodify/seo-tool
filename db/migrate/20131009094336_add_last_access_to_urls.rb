class AddLastAccessToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :last_access, :datetime
  end
end
