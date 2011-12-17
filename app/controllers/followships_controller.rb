class FollowshipsController < ApplicationController
  def create
    @user = User.find(params[:followship][:followed_id])
    current_user.follow!(@user)

    respond_to do |format|
      format.html { redirect_to all_users_path }
      format.js
    end
  end

  def destroy
    @user = Followship.find(params[:id]).followed
    current_user.unfollow!(@user)

    respond_to do |format|
      format.html { redirect_to all_users_path }
      format.js
    end
  end
end
