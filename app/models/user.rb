class User < ActiveRecord::Base
  
  before_save { self.email = email.downcase }
  
  # 画像アップロード
  mount_uploader :image, ImageUploader
  
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password
  
  
  # ユーザーとつぶやきを定義  User：microposts = 1：n
  has_many :microposts
  
  # お気に入り
  has_many :favorites, dependent: :destroy
  has_many :favorite_microposts, through: :favorites, source: :micropost
  
  # フォローしている
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed


  # フォロワー
  has_many :followed_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :followed_users, through: :followed_relationships, source: :follower
  
  
  
  
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  # フィードには、自分のささやきと、自分がフォローしているユーザーのつぶやきを表示（取得）
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end

end
