class TagsController < ApplicationController
  before_action :authenticate_admin!, except:[:index, :show]
  breadcrumb 'Tags', :tags_path
  def index
    @tags = Tag.paginate(page: params[:page], per_page: 4)
  end

  def show
    tag
    breadcrumb tag.name, tag_path(tag)
  end

  def new
    @tag = tag.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @tag = tag.new(tag_params)
    if @tag.save
      redirect_to @tag
    else
      render :new
    end
  end

  def edit
    tag
  end

  def update
    if tag.update(tag_params)
      redirect_to tag
    else
      render :edit 
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      redirect_to tags_path
      flash[:success] = "Deleted succesfully."
    end
  end

  private

  def tag
    @tag ||= Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag)
      .permit(:name, :color, has_tags_attributes: [:id])
  end
end
