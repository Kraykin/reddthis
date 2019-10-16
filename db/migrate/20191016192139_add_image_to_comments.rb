class AddImageToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :image, :string
  end
end
