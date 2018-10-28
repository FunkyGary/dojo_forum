class CommentsController < ApplicationController
  before_action :set_article, only: [:edit, :create, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]
  

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to article_path(@article)
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "comment was successfully updated"
      redirect_to article_path(@article)
    else
      flash.now[:alert] = "article was failed to update"
      render :edit
    end
  end

  def destroy
    if current_user.comments
      @comment.destroy
      redirect_to article_path(@article)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_article
    @comment = Comment.find(params[:id])
    @article = Article.find(@comment.article_id)
  end
end
