class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(following_id: params[:following_id])

    if @friendship.save
      flash[:notice] = "Successfully sent friend request"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end
  def destroy
    @friendship = current_user.friendships.where(following_id: params[:following_id]).first
    @friendship.destroy
    flash[:alert] = "Friendship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
