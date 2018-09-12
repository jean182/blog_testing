class TagsController < ApplicationController
  before_action :authenticate_admin!, except:[:index, :show]
  before_action :set_tag, except: [:index, :new, :create]
  breadcrumb 'Tags', :tags_path
  def index
    @tags = Tag.paginate(page: params[:page], per_page: 4)
  end

  def show
    breadcrumb @tag.name, tag_path(@tag)
    @posts = @tag.posts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @tag = Tag.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to @tag
    else
      render :new
    end
  end

  def edit
    breadcrumb @tag.name, tag_path(@tag)
    breadcrumb 'Edit', edit_tag_path(@tag)
  end

  def update
    if @tag.update(tag_params)
      redirect_to @tag
    else
      render :edit 
    end
  end

  def destroy
    if @tag.destroy
      redirect_to tags_path
      flash[:success] = "Deleted succesfully."
    end
  end

  private

  def set_tag
    @tag ||= Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag)
      .permit(:name, :color, has_tags_attributes: [:id])
  end
end
