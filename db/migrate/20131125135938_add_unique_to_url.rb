class AddUniqueToUrl < ActiveRecord::Migration
  def change
    execute "ALTER IGNORE TABLE `urls` ADD UNIQUE INDEX (url)"
  end
end
