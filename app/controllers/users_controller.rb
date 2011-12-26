class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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
    @user = User.find(params[:id]) || current_user

    @users = @user.followers.where("users.? like ?",@selected,@search_like).order("updated_at desc").page(@page_number).per(15)
    @total = @user.followers.where("users.? like ?",@selected,@search_like).order("updated_at desc").count
  end

  def following
    @page_number = params[:page] || 1
    @search = params[:search]
    @search_like = "%"+@search.to_s+"%"
    @select_array = ["id","nick_name","email"]
    @selected = params[:user_attr] || "id"
    @user = User.find(params[:id]) || current_user

    @users = @user.following.where("users.? like ?",@selected,@search_like).order("updated_at desc").page(@page_number).per(15)
    @total = @user.following.where("users.? like ?",@selected,@search_like).order("updated_at desc").count
  end

  def notes_following
    @page_number = params[:page] || 1
    @labels_select = ["id","name","comment"]
    @label_selected = params[:label] || "id"
    @search = params[:search]
    @search_like = "%"+@search.to_s+"%"
    @as_notes = AsNote
    @user = User.find(params[:id]) || current_user

    @as_notes = @user.fd_notes.where("as_notes.? like ?",@label_selected,@search_like).page(@page_number).per(15)
    @total = @user.fd_notes.where("as_notes.? like ?",@label_selected,@search_like).count

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @as_notes }
    end
  end

  def all
    @page_number = params[:page] || 1
    @search = params[:search]
    @search_like = "%"+@search.to_s+"%"
    @select_array = ["id","nick_name","email"]
    @selected = params[:user_attr] || "id"
    @user = current_user

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
