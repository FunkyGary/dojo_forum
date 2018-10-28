class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: "User"
  validates :following_id, uniqueness: { scope: :user_id }
  def create
    @friendship = current_user.friendships.build(following_id: params[:following_id])

    if @friendship.save
      flash[:notice] = "Successfully sent request"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end
end
