class Retweet < ActiveRecord::Base
  belongs_to :motomicropost, class_name: "Micropost", foreign_key: "motomicropost_id"
  belongs_to :sakimicropost, class_name: "Micropost", foreign_key: "sakimicropost_id"
end
