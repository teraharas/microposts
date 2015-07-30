class StaticPagesController < ApplicationController
  def home
    # インスタンスにログインしたユーザーに紐付いたMicropostsデータを渡す
    @micropost = current_user.microposts.build if logged_in?
  end
end
