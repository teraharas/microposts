class AddImageToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :image, :file
    add_column :microposts, :remove_image, :boolean
    add_column :microposts, :image_cache, :string
  end
end
