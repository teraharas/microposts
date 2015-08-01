class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # インスタンスにログインしたユーザーに紐付いたMicropostsデータを渡す
      @micropost = current_user.microposts.build
      # フィード
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
  
end
