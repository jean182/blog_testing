class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def edit
    category
  end

  def update
    category.update(category_params)
    render :edit
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
