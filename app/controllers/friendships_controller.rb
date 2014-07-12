class FriendshipsController < ApplicationController

  def create
    friendship = Friendship.new()
    friendship.owned_friend = User.find(params[:user_id])
    friendship.friend_owner = current_user
    sleep(1)
    if friendship.save
      render :json => friendship
    else
      flash[:errors] = friendship.errors.full_messages
      render :json => flash[:errors], status: 422
    end  
  end
  
  def destroy
    sleep(1)
    Friendship.find(params[:id]).destroy
    render :json => params[:id]
  end
end