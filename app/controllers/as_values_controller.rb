class AsValuesController < ApplicationController
  # GET /as_values
  # GET /as_values.xml
  def index
    @as_note = AsNote.find(params[:as_note_id])
    @labels = @as_note.get_sorted_labels(@as_note)
    #@numeros = @as_note.as_labels.first.as_values.all(:select=>"numero",:order=>"numero DESC").collect{|n| n.numero}
    #todo ..when values/label is nil
    @l1_values = @as_note.as_labels.first.as_values.all(:select=>"id,numero,value", :order=>"numero DESC")

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @as_values }
    end
  end

  # GET /as_values/1
  # GET /as_values/1.xml
  def show
    @as_note = AsNote.find(params[:as_note_id])
    @labels = @as_note.get_sorted_labels(@as_note)
    @numero = params[:numero]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @as_value }
    end
  end

  # GET /as_values/new
  # GET /as_values/new.xml
  def new
    @as_note = AsNote.find(params[:as_note_id])
    #todo: modify get_sorted_labels method
    #@labels = @as_note.as_labels
    @labels = @as_note.get_sorted_labels(@as_note)

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
    values = params[:content]
    AsValue.save_entire_record(values,@as_note)

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
