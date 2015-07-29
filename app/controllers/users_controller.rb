class UsersController < ApplicationController
  before_action :show, only: [:edit, :update]
  
  def show # 追加
   @user = User.find(params[:id])
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
                                 :password_confirmation, :profile, :area, :homepage )
  end
  
end
