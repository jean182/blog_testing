class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, except: [:index, :new, :create]
  before_action :authenticate_editor!, only:[:new, :create, :update]
  before_action :authenticate_admin!, only:[:destroy]
  before_action :editor_is_post_owner!, only:[:edit]
  breadcrumb 'All Posts', :posts_path

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
    breadcrumb @post.title, post_path(@post)
  end

  def new
    @post = current_user.posts.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    breadcrumb @post.title, post_path(@post)
    breadcrumb 'Edit', edit_post_path(@post)
    build_has_tags
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

  def set_post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, tag_ids: [])
  end

  def build_has_tags
    Tag.all.each do |tag|
      @post.has_tags.build(tag_id: tag.id)
    end
  end
end
