class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])

    if current_user.comments
      @comment.destroy
      redirect_to article_path(@article)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
