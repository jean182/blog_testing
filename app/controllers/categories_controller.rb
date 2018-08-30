class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page], per_page: 4)
  end

  def show
    category
  end

  def new
    @category = Category.new
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

  private

  def category
    @category ||= Category.find(params[:id])
  end

  def category_params
    params.require(:category)
      .permit(:name, :color, has_categories_attributes: [:id])
  end
end
