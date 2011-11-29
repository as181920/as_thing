class UsersController < ApplicationController
  def index
    @users = User.all
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
