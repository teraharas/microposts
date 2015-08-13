class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.references :motomicropost, index: true
      t.references :sakimicropost, index: true

      t.timestamps null: false
      
      t.index [:motomicropost_id, :sakimicropost_id], unique: true
    end
  end
end
