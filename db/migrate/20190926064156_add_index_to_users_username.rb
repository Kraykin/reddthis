class AddIndexToUsersUsername < ActiveRecord::Migration[5.2]
  change_table :users do |t|
    t.index :username
  end
end
