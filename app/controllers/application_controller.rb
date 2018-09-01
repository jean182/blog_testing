class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_editor!
    redirect_to posts_path, :flash => { :error => "You don't have the permissions to do this!" } unless user_signed_in? && current_user.editor?
  end

  def authenticate_admin!
    redirect_to request.referrer, :flash => { :error => "You don't have the permissions to do this!" } unless user_signed_in? && current_user.admin?
  end

  def editor_is_post_owner!
    redirect_to posts_path, :flash => { :error => "You don't have the permissions to edit this! "} unless user_signed_in? && current_user.id == post.user_id
  end
end
