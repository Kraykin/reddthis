class AddUsernameToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :username, :string, null: false, index: true, unique: true
  end
end
