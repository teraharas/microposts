class UsersController < ApplicationController
  before_action :show, only: [:edit, :update]
  before_action :get_AllData, only: [:index, :show, :favorites]
  
  def index
    @users = User.all
    # ページング追加
    @users_page = @users.page(params[:page]).per(8).order(:id)
  end
  
  
  def show # 追加
    # ユーザーを取得してセット
    @user = User.find(params[:id])
    # ユーザーに紐づくつぶやきをセット
    @microposts = @user.microposts.order(created_at: :desc)
    # ページング追加
    @microposts = @microposts.page(params[:page]).per(8)
  end


  def new
    @user = User.new
  end
  
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Micropostsへようこそ"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  
  def edit
    
  end
  
  
  def followings
    @user = User.find(params[:id])
    @users = @user.following_users
  end
  
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followed_users
  end
  
  
  # お気に入り
  def favorites
    @user = User.find(params[:id])
    @microposts = @user.favorite_microposts
    # ページング追加
    @microposts = @microposts.page(params[:page]).per(8)
  end
  
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      flash[:success] = "プロフィールを編集しました。"
      redirect_to @user
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile, :area, :homepage, 
                                 :image, :image_cache, :remove_image )
  end
  
  
  def get_AllData
      # ユーザーとリツイート情報をすべて取得する。
      @userAll = User.all
      @retweetAll = Retweet.all
      @micropostAll = Micropost.all
  end

end
