class AddProfToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :string
    add_column :users, :area, :string
    add_column :users, :homepage, :string
  end
end
