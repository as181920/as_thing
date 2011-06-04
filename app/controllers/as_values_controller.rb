class AsValuesController < ApplicationController
  # GET /as_values
  # GET /as_values.xml
  def index
    @as_note = AsNote.find(params[:as_note_id])
    @as_labels = @as_note.as_labels
    #@as_values = AsValue.all
    #todo ..when as_values=nil
    @as_values=[]

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @as_values }
    end
  end

  # GET /as_values/1
  # GET /as_values/1.xml
  def show
    @as_value = AsValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @as_value }
    end
  end

  # GET /as_values/new
  # GET /as_values/new.xml
  def new
    @as_note = AsNote.find(params[:as_note_id])

    respond_to do |format|
      format.html # new.html.erb
      #format.xml  { render :xml => @as_value }
    end
  end

  # GET /as_values/1/edit
  def edit
    @as_value = AsValue.find(params[:id])
  end

  # POST /as_values
  # POST /as_values.xml
  def create
    @as_note = AsNote.find(params[:as_note_id])
    last_value = AsValue.first(:select=>:numero,:order=>"numero DESC")
    if last_value then
      numero = last_value.numero + 1
    else
      numero = 0
    end
    values = params[:content]

    AsValue.transaction do
      values.each do |value|
        @as_value = AsValue.new
        @as_value.numero = numero
        @as_value.as_label_id = value[0]
        @as_value.value = value[1]
        @as_value.save
      end
    end

    respond_to do |format|
      format.html { redirect_to as_note_as_values_url(@as_note) }
      #format.xml  { render :xml => @as_value, :status => :created, :location => @as_value }
    end
  end

=begin
def create_all
    if asr[1] == "" then
      @asrecord.content = nil
    else
      @asrecord.content = asr[1]
    end
end
=end

  # PUT /as_values/1
  # PUT /as_values/1.xml
  def update
    @as_value = AsValue.find(params[:id])

    respond_to do |format|
      if @as_value.update_attributes(params[:as_value])
        format.html { redirect_to(@as_value, :notice => 'As value was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @as_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /as_values/1
  # DELETE /as_values/1.xml
  def destroy
    @as_value = AsValue.find(params[:id])
    @as_value.destroy

    respond_to do |format|
      format.html { redirect_to(as_values_url) }
      format.xml  { head :ok }
    end
  end
end
