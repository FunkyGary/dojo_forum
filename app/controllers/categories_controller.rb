class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @articles = Article.page(params[:page]).per(9)
  end
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @articles = @category.articles.page(params[:page]).per(10)
  end
end
