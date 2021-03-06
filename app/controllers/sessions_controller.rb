class SessionsController < ApplicationController
  def new
    if current_user then
      redirect_to as_notes_path
    end
  end

  def create
    user = User.authenticate(params[:email],params[:password])
    if user
      session[:user_id] = user.id
      redirect_to as_notes_path, :notice => "Logged in!"
    else
      redirect_to "/sessions/new", :notice=>"Invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
