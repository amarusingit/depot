class ApplicationController < ActionController::Base
  before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  
    def authorize
#byebug
      return if User.count.zero?

      if request.format.HTML?
          unless User.find_by(id: session[:user_id]) 
              redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию"
          end
      else
          if user = authenticate_or_request_with_http_basic do |u, p|
                User.find_by_name(u).try(:authenticate, p)
              end
          session[:user_id] = user.id      

          end    
          #byebug    
      end
    end
end
