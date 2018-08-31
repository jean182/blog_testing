class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_editor!
    redirect_to root_path, :flash => { :error => "Not allowed!" } unless user_signed_in? && current_user.editor?
  end

  def authenticate_admin!
    redirect_to root_path, :flash => { :error => "Not allowed!" } unless user_signed_in? && current_user.admin?
  end
end
