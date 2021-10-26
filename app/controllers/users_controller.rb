class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :likes]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 25)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @bookposts = pagy(@user.bookposts.order(id: :desc)) 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザーを登録しました。"
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  
  def likes
    @user = User.find(params[:id])
    @pagy, @likings = pagy(@user.likings)
  end
  
  private
  
  def bookpost_params
    params.require(:bookpost).permit(:content, :title)
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
