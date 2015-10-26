class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale_from_params
  before_action :set_currency_rate
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  
    def set_currency_rate
        session[:currency_rate]=1
        if params[:locale] != 'en'
           session[:currency_rate]=Currency.where(["datecurs <= ?", Time.zone.today]).last.curs
        end  
    end  

    def authorize
      #byebug
      return if User.count.zero?
      if request.format.HTML?
          unless User.find_by(id: session[:user_id]) 
              redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию"
          end
      else
          if user = authenticate_or_request_with_http_basic do |u, p|
                  User.find_by_name(u).try(:authenticate, p) end
              session[:user_id] = user.id if !performed?     
          end    
          #byebug    
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] =
              "#{params[:locale]} translation not available"
              # перевод недоступен
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
       { locale: I18n.locale }
    end

end
