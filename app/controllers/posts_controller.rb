class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :post, except: [:index, :new, :create]
  before_action :authenticate_editor!, only:[:new, :create, :update]
  before_action :authenticate_admin!, only:[:destroy]
  before_action :editor_is_post_owner!, only:[:edit]
  def index
    @posts = Post.paginate(page: params[:page], per_page: 2)
  end

  def show
  end

  def new
    @post = current_user.posts.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    build_has_categories
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def update

    if post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path
      flash[:success] = "Deleted succesfully."
    end
  end

  private

  def post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, category_ids: [])
  end

  def build_has_categories
    Category.all.each do |category|
      post.has_categories.build(category_id: category.id)
    end
  end
end
