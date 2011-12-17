class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user = User.authenticate(@user.email,params[:old][:password])
    if user
      #session[:user_id] = user.id
      @user.update_attributes(params[:user])
      redirect_to as_notes_path, :notice => "user setting updated!"
    else
      flash.now.alert = "wrong password"
      render "edit"
    end
  end

  def followers
    @page_number = params[:page] || 1
    @search = params[:search]
    @search_like = "%"+@search.to_s+"%"
    @select_array = ["id","nick_name","email"]
    @selected = params[:user_attr] || "id"

    @users = current_user.followers.where("users.? like ?",@selected,@search_like).order("updated_at desc").page(@page_number).per(15)
    @total = current_user.followers.where("users.? like ?",@selected,@search_like).order("updated_at desc").count
  end

  def following
    @page_number = params[:page] || 1
    @search = params[:search]
    @search_like = "%"+@search.to_s+"%"
    @select_array = ["id","nick_name","email"]
    @selected = params[:user_attr] || "id"

    @users = current_user.following.where("users.? like ?",@selected,@search_like).order("updated_at desc").page(@page_number).per(15)
    @total = current_user.following.where("users.? like ?",@selected,@search_like).order("updated_at desc").count
  end

  def all
    @page_number = params[:page] || 1
    @search = params[:search]
    @search_like = "%"+@search.to_s+"%"
    @select_array = ["id","nick_name","email"]
    @selected = params[:user_attr] || "id"

    @users = User.where("users.? like ?",@selected,@search_like).order("updated_at desc").page(@page_number).per(15)
    @total = User.where("users.? like ?",@selected,@search_like).order("updated_at desc").count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice=>"Signed up!"
    else
      render "new", :notice=>"error occured when sign up!"
    end
  end
end
