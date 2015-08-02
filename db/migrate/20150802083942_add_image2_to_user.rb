class AddImage2ToUser < ActiveRecord::Migration
  def change
    add_column :users, :remove_image, :boolean
    add_column :users, :image_cache, :string
  end
end
