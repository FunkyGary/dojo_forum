class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :comments, :posts, :drafts, :friends, :collects]

  def show
    @comments = @user.comments.uniq
  end

  def drafts    
    @drafts = Article.where(user_id: @user.id, public: false).order(updated_at: :desc)    
  end

  def comments
    @comments = @user.comments.uniq
  end

  def collects
    @collected_articles = @user.favorited_articles.uniq
  end

  def posts
    @articles = @user.articles.uniq
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def friends
    @not_yet_accepted_friends = current_user.not_yet_accepted_friends.all
    @not_yet_responded_friends = current_user.not_yet_responded_friends.all

    @friends = @user.all_friends
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
