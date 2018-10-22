class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "article was successfully created"
      redirect_to admin_articles_path
    else
      flash.now[:alert] = "article was failed to create"
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:name, :description)
  end
end
