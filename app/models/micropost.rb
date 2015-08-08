class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  # 画像アップロード
  mount_uploader :image, ImageUploader
  
  # ユーザーID：必須
  validates :user_id, presence: true
    
  # 内容：必須、140字以内
  validates :content, presence: true, length: { maximum: 140 }
  
  
  def favorited_by? user
    favorites.where(user_id: user.id).exists?
  end
  
end
