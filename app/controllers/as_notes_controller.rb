class AsNotesController < ApplicationController
  # GET /as_notes
  # GET /as_notes.xml
  def index
    @as_notes = AsNote.all

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

    respond_to do |format|
      if @as_note.save
        format.html { redirect_to(@as_note, :notice => 'As note was successfully created.') }
        format.xml  { render :xml => @as_note, :status => :created, :location => @as_note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @as_note.errors, :status => :unprocessable_entity }
      end
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
    @as_note.destroy_all_releated_data(@as_note)

    respond_to do |format|
      format.html { redirect_to(as_notes_url) }
      format.xml  { head :ok }
    end
  end
end
