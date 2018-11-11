class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @categories = Category.all
    @articles = Article.page(params[:page]).per(20)
  end
  def show
    @category = Category.find(params[:id])
    @categories = Category.all

    @q = @category.articles.where(public: true).ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page]).per(20).order(updated_at: :desc)
  end
end
