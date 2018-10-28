class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.page(params[:page]).per(10)
    @categories = Category.all
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "article was successfully created"
      redirect_to articles_path
    else
      flash.now[:alert] = "article was failed to create"
      render :new
    end
  end
  def show
    @comment = Comment.new
  end
  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "article was successfully updated"
      redirect_to articles_path(@article)
    else
      flash.now[:alert] = "article was failed to update"
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
    flash[:alert] = "article was deleted"
  end

  def feeds
    @recent_articles = Article.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :image, :category_id)
  end
  
  def set_article
    @article = Article.find(params[:id])
  end
end
