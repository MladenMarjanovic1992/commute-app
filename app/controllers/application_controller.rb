class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  after_action -> { flash.discard }, if: -> { request.xhr? }
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end
  
  def redirect_back_or(path)
    redirect_to request.referer || path
  end
  
  protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :about_me, :image])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :about_me, :image])
    end
end
