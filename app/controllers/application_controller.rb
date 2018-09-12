class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:username, :email)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:username, :email, :name, :password, :password_confirmation, :current_password)
    end
  end

  def authenticate_editor!
    redirect_to posts_path, :flash => { :error => "You don't have the permissions to do this!" } unless user_signed_in? && current_user.editor?
  end

  def authenticate_admin!
    redirect_to request.referrer, :flash => { :error => "You don't have the permissions to do this!" } unless user_signed_in? && current_user.admin?
  end

  def editor_is_post_owner!
    redirect_to posts_path, :flash => { :error => "You don't have the permissions to edit this! "} unless user_signed_in? && current_user.id == @post.user_id
  end
end
