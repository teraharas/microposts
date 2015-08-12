class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "ささやきを投稿しました！"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  
  def destroy
    # ささやきをインスタンスにセット
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    # ささやきを削除
    @micropost.destroy
    flash[:success] = "ささやきは消えました！"
    redirect_to request.referrer || root_url
  end
  
  
  def micropost_params
    params.require(:micropost).permit(:content, 
                                 :image, :image_cache, :remove_image )
  end
end
