class Micropost < ActiveRecord::Base
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_microposts, through: :favorites, source: :micropost
  
  has_many :saki_retweets, class_name:  "Retweet",
                                    foreign_key: "sakimicropost_id",
                                    dependent:   :destroy
  has_many :saki_microposts, through: :saki_retweets, source: :sakimicropost
  
  has_many :moto_retweets, class_name:  "Retweet",
                                     foreign_key: "motomicropost_id",
                                     dependent:   :destroy
  has_many :moto_microposts, through: :moto_retweets, source: :motomicropost

  
  # 画像アップロード
  mount_uploader :image, ImageUploader
  
  # ユーザーID：必須
  validates :user_id, presence: true
    
  # 内容：必須、140字以内
  validates :content, presence: true, length: { maximum: 140 }
 
  # お気に入り登録されているか
  def favorited_by? user
    favorites.where(user_id: user.id).exists?
  end
  
  
  # リツイートされているか
  def retweeted_by? micropost
    saki_microposts.where(id: micropost.id).exists?
  end
  
end
