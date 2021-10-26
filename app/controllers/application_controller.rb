class ApplicationController < ActionController::Base
 
    include SessionsHelper
    include Pagy::Backend
    
    private
    
    
    def require_user_logged_in
        unless logged_in?
            redirect_to login_url
        else
            @user = current_user
        end
    end
        
end
