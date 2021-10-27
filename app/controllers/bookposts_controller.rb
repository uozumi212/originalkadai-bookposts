class BookpostsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:destroy]
    
  def index
    @pagy, @bookposts = pagy(Bookpost.order(id: :desc), items: 25)
    
  end
  
  def show
    @bookpost = Bookpost.find(params[:id])
  end
  
  def new
    @bookpost = Bookpost.new
    @user = current_user
  end

  def create
    @user = current_user
    @bookpost = current_user.bookposts.build(bookpost_params)
    if @bookpost.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else 
      @pagy, @bookposts = pagy(current_user.bookposts.order(id: :desc))
      flash.now[:danger] = '投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @bookpost.destroy
    flash[:danger] = "投稿を削除しました。"
    redirect_to @bookpost
  end

  

  private

  def bookpost_params
    params.require(:bookpost).permit(:content, :title)
  end
  
  def correct_user
    @bookpost = current_user.bookposts.find_by(id: params[:id])
    unless @bookpost
      redirect_to root_url
    end
  end
end
