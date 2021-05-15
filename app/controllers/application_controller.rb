class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_top_path
    when Customer
      root_path
    end
  end
  
  #ログアウト後のリダイレクト先(admin)
  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :tell])
  end
end
