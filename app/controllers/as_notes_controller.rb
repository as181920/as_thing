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

    @as_notes = current_user.as_notes.where("as_notes.? like ?",@label_selected,@search_like).page(@page_number).per(3)
    @total = current_user.as_notes.where("as_notes.? like ?",@label_selected,@search_like).count

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @as_notes }
    end
  end

  def public
    #@as_notes = AsNote.public_notes
    @page_number = params[:page] || 1
    @labels_select = ["id","name","comment"]
    @label_selected = params[:label] || "id"
    @search = params[:search]
    @search_like = "%"+@search.to_s+"%"
    @as_notes = AsNote.where("public=? and as_notes.? like ?",true,@label_selected,@search_like).page(@page_number).per(3)
    @total = AsNote.where("public=? and as_notes.? like ?",true,@label_selected,@search_like).count

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @as_notes }
    end
  end

  # GET /as_notes/1
  # GET /as_notes/1.xml
  def show
    @as_note = AsNote.find(params[:id])

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
  end

  # POST /as_notes
  # POST /as_notes.xml
  def create
    @as_note = AsNote.new(params[:as_note])
    @ownership = Ownership.new
    @ownership.as_note = @as_note
    @ownership.user = current_user

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
    #@as_note.destroy_all_releated_data(@as_note)
    @as_note.destroy

    respond_to do |format|
      format.html { redirect_to(as_notes_url) }
      format.xml  { head :ok }
    end
  end
end
