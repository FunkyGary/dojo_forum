class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_article, only: [:show, :edit, :update, :destroy, :favorite, :unfavorite]

  def index
    if current_user
      @q = Article.where(public: true).where(authority: "all").authorized_articles(current_user).ransack(params[:q])
      @articles = @q.result(distinct: true).page(params[:page]).per(20).order(created_at: :asc)
    else
      @q = Article.where(public: true).where(authority: "all").ransack(params[:q])
      @articles = @q.result(distinct: true).page(params[:page]).per(20).order(created_at: :asc)
   end
    @categories = Category.all
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.create(article_params)
    @article.user = current_user
    if params[:commit] == "Publish"
      @article.public = true
      if @article.save
        redirect_to root_path
      else
        flash.now[:alert]= @article.errors.full_messages.to_sentence
        render :edit
      end
    else
      @article.public = false
      if @article.save
        redirect_to drafts_user_path(current_user)
      else
        flash.now[:alert]= @article.errors.full_messages.to_sentence
        render :edit
      end
    end
  end

  def drafts
    @article = Article.new(article_params)
    @article.user = current_user
    @article.public = false
    if @article.save
      redirect_to drafts_user_path(current_user)
      binding.pry
    else
      flash.now[:alert]= @article.errors.full_messages.to_sentence
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @article.viewed_count += 1
    @article.save
    @comments = @article.comments.page(params[:page]).per(20)
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
    @user_count = User.count
    @article_count = Article.count
    @comment_count = Comment.count
    @populararticles = Article.order(replies_count: :desc).limit(10)
    @activeusers = User.order(comment_counts: :desc).limit(10)
  end

  def favorite
    @article.favorites.create!(user: current_user)
    @article.count_favorites
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unfavorite
    favorites = Favorite.where(article: @article, user: current_user)
    favorites.destroy_all
    @article.count_favorites
    redirect_back(fallback_location: root_path)
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :image, :authority , :category_ids => [])
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
