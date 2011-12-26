class AsNotesController < ApplicationController
  before_filter :require_login, :except => [:public]

  # GET /as_notes
  # GET /as_notes.xml
  def index
    #@as_notes = AsNote.all
    @page_number = params[:page] || 1
    @labels_select = ["id","name","comment"]
    @label_selected = params[:label] || "id"
    @search = params[:search]
    @search_like = "%"+@search.to_s+"%"
    @user = current_user

    @as_notes = @user.as_notes.where("as_notes.? like ?",@label_selected,@search_like).order("ownerships.position").page(@page_number).per(15)
    @total = @user.as_notes.where("as_notes.? like ?",@label_selected,@search_like).count

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @as_notes }
    end
  end

  def sort_all
    n_id = AsNote.find(params[:id]).id.to_i
    o_position = current_user.ownerships.where("as_note_id = ?",n_id).first.position.to_i
    s_position = params[:s_position].to_i
    if s_position > o_position then
      current_user.ownerships.update_all("position = position - 1", "position <= #{s_position} and position > #{o_position}")
      current_user.ownerships.update_all("position = #{s_position}", "as_note_id = #{n_id}")
    elsif s_position < o_position then
      current_user.ownerships.update_all("position = position + 1", "position >= #{s_position} and position < #{o_position}")
      current_user.ownerships.update_all("position = #{s_position}", "as_note_id = #{n_id}")
    else
    end
  end

  def sort
    position_array = []
    params[:as_note].each do |n_id|
      #position_array << AsNote.find(n_id.to_i).ownerships.where("user_id = ?",current_user).first.position
      position_array << Ownership.where("as_note_id = ? and user_id = ?",n_id.to_i,current_user).first.position
    end
    position_sorted = position_array.sort

    position_sorted.each_with_index do |p, i|
      ownership=Ownership.where("as_note_id = ? and user_id = ?",params[:as_note][i].to_i,current_user).first
      ownership.position = position_sorted[i]
      ownership.save
    end
  end

  def public
    #@as_notes = AsNote.public_notes
    @page_number = params[:page] || 1
    @labels_select = ["id","name","comment"]
    @label_selected = params[:label] || "id"
    @search = params[:search]
    @search_like = "%"+@search.to_s+"%"
    @as_notes = AsNote.where("public=? and as_notes.? like ?",true,@label_selected,@search_like).page(@page_number).per(15)
    @total = AsNote.where("public=? and as_notes.? like ?",true,@label_selected,@search_like).count

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @as_notes }
    end
  end

  def owners
    @as_note = AsNote.find(params[:id])
    @users = @as_note.owners
  end

  def followers
    @as_note = AsNote.find(params[:id])
    @users = @as_note.followers
  end

  # GET /as_notes/1
  # GET /as_notes/1.xml
  def show
    @as_note = AsNote.find(params[:id])
    #@position = @as_note.ownerships.where("user_id = ?",current_user).first.position

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @as_note }
    end
  end

  # GET /as_notes/new
  # GET /as_notes/new.xml
  def new
    @as_note = AsNote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @as_note }
    end
  end

  # GET /as_notes/1/edit
  def edit
    @as_note = AsNote.find(params[:id])
    @position = @as_note.ownerships.where("user_id = ?",current_user).first.position
    @position_sorted = (Ownership.where("user_id = ?",current_user).collect {|o| o.position }).sort
  end

  # POST /as_notes
  # POST /as_notes.xml
  def create
    @as_note = AsNote.new(params[:as_note])
    @ownership = Ownership.new
    @ownership.as_note = @as_note
    @ownership.user = current_user
    position_max = current_user.ownerships.order("position desc").first
    if position_max then 
      @ownership.position = position_max.position.to_i + 1
    else
      @ownership.position = 1
    end

    if @ownership.save then
      respond_to do |format|
        if @as_note.save
          format.html { redirect_to(@as_note, :notice => 'As note was successfully created.') }
          format.xml  { render :xml => @as_note, :status => :created, :location => @as_note }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @as_note.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_as_note_path, :notice=>"ownership save failed!"
    end
  end

  # PUT /as_notes/1
  # PUT /as_notes/1.xml
  def update
    @as_note = AsNote.find(params[:id])

    respond_to do |format|
      if @as_note.update_attributes(params[:as_note])
        format.html { redirect_to(@as_note, :notice => 'As note was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @as_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /as_notes/1
  # DELETE /as_notes/1.xml
  def destroy
    @as_note = AsNote.find(params[:id])

    ActiveRecord::Base.transaction do
      @as_note.owners.each do |user|
        u_ownership = @as_note.ownerships.where("user_id = ?",user.id).first
        u_position = u_ownership.position.to_i
        u_ownership.destroy
        user.ownerships.update_all("position = position - 1", "position > #{u_position}")
      end
      #@as_note.ownerships.each {|os| os.destroy}
      @as_note.destroy
    end

    respond_to do |format|
      format.html { redirect_to(as_notes_url) }
      format.xml  { head :ok }
    end
  end
end
