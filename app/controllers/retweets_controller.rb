class RetweetsController < ApplicationController
    before_filter :logged_in_user, only: [:create, :destroy]
  
    def create
        @motomicropost = Micropost.find(params[:micropost_id])
        
        # 新しいささやきのレコード作成
        @sakimicropost = Micropost.create(
            :user_id => current_user.id,
            :content => @motomicropost.content,
            :image => @motomicropost.image.file,
            :remove_image => @motomicropost.remove_image,
            :image_cache => @motomicropost.image_cache
        )
        # @sakimicropost = Micropost.new
        # @sakimicropost.attributes = @motomicropost.attributes

        # ブレークポイント
        # binding.pry
        # @sakimicropost.save


        if !@sakimicropost.new_record?
        else
            render 'static_pages/home'
        end        
        
        # リツイート情報を更新する
        @retweet = @sakimicropost.saki_retweets.build(motomicropost_id: @motomicropost.id, sakimicropost_id: @sakimicropost.id)

        if @retweet.save
            flash[:success] = "リツイートしました！"
            redirect_to root_url
        else
            flash[:alert] = "リツイートできませんでした。"
            redirect_to root_url
        end
        
    end
    
    
    def destroy
        @micropost = Micropost.find(params[:micropost_id])

        # リツイート情報を削除
        @retweet = @micropost.saki_retweets.find_by!(sakimicropost_id: params[:micropost_id])
        @retweet.destroy

        # リツイートで作成されていたささやきを削除
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy

        flash[:success] = "リツイートを削除しました。"
        redirect_to root_url
    end


    private
    def micropost_params
        params.require(:micropost).permit(:content, 
                                 :image, :image_cache, :remove_image )
    end
end