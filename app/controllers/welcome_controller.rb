class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :about]
  def index
  end

  def about
  end

  def dashboard
    if user_signed_in?
    @posts = current_user.posts.paginate(page: params[:page], per_page: 2)
    end
  end
end
