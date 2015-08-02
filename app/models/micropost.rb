class Micropost < ActiveRecord::Base
  belongs_to :user
  
  # 画像アップロード
  mount_uploader :image, ImageUploader
  
  # ユーザーID：必須
  validates :user_id, presence: true
    
  # 内容：必須、140字以内
  validates :content, presence: true, length: { maximum: 140 }
end
