class Admin::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_article, only: [:show, :edit, :update, :destroy]

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
      redirect_to articles_path
    else
      flash.now[:alert] = "article was failed to create"
      render :new
    end
  end
  def show
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

  private

  def article_params
    params.require(:article).permit(:title, :description, :image, :category_id)
  end
  def set_article
    @article = Article.find(params[:id])
  end
end
  