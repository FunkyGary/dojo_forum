class CommentsController < ApplicationController
  before_action :authenticate_user!
  

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    @article.replies_count = @article.comments.size
    @article.save

    current_user.comment_counts = current_user.comments.size
    current_user.save

    @comment.save!
    redirect_to article_path(@article)
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = Comment.where(article_id: @article).find(params[:comment_id])
  end

  def update
    @article = Article.find(params[:id])
    @comment = Comment.where(article_id: @article).find(params[:article_id])
    if @comment.update(comment_params)
      flash[:notice] = "comment was successfully updated"
      redirect_to article_path(@article)
    else
      flash.now[:alert] = "article was failed to update"
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = Comment.where(article_id: @article).find(params[:comment_id])
    if current_user.comments
      @article.replies_count = @article.comments.size
      @article.save
  
      current_user.comment_counts = current_user.comments.size
      current_user.save

      @comment.destroy
      redirect_to article_path(@article)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
