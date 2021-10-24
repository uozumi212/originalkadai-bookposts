class LikesController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :destroy]
  
  
    
  def create
    bookpost = Bookpost.find(params[:like_id])
    current_user.like(bookpost)
    flash[:success] = "投稿をいいねしました。"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    bookpost = Bookpost.find(params[:like_id])
    current_user.unlike(bookpost)
    flash[:danger] = "いいねを解除しました"
    redirect_back(fallback_location: root_path)
  end
end
