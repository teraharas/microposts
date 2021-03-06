class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # インスタンスにログインしたユーザーに紐付いたMicropostsデータを渡す
      @micropost = current_user.microposts.build
      # フィード
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      # フィードのページング追加
      @feed_items_page = @feed_items.page(params[:page]).per(8)
      
      # ユーザーとリツイート情報をすべて取得する。
      @userAll = User.all
      @retweetAll = Retweet.all
      @micropostAll = Micropost.all
    end
  end
end
