class CategoriesController < ApplicationController
  before_action :authenticate_admin!, except:[:index, :show]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 4)
  end

  def show
    category
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def edit
    category
  end

  def update
    if category.update(category_params)
      redirect_to category
    else
      render :edit 
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path
      flash[:success] = "Deleted succesfully."
    end
  end

  private

  def category
    @category ||= Category.find(params[:id])
  end

  def category_params
    params.require(:category)
      .permit(:name, :color, has_categories_attributes: [:id])
  end
end
