class ToppagesController < ApplicationController
  
  def index
    if logged_in?
      @user = current_user
      @bookpost = current_user.bookposts.build
      @pagy, @bookposts = pagy(current_user.bookposts.order(id: :desc))
    end
  end
end
