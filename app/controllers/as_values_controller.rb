class AsValuesController < ApplicationController
  # GET /as_values
  # GET /as_values.xml
  def index
    @as_note = AsNote.find(params[:as_note_id])
    @labels = @as_note.get_sorted_labels(@as_note)
    #@numeros = @as_note.as_labels.first.as_values.all(:select=>"numero",:order=>"numero DESC").collect{|n| n.numero}
    #todo ..when label is nil, optimize the handle method, consider use self_defined validation method
    unless @as_note.as_labels.first
      redirect_to(@as_note, :notice =>'Should add labels first.')
    else
      #todo asc,desc
      @direction = params[:direction] == "desc" ? "asc" : "desc"
      case params[:sort]
      when nil
        @l_values = @as_note.as_labels.first.as_values.all(:select=>"id,numero,value", :order=>"numero desc")
      when "No."
        @l_values = @as_note.as_labels.first.as_values.all(:select=>"id,numero,value", :order=>"numero "+@direction)
      else
        @l_values = @as_note.as_labels.find_by_name(params[:sort]).as_values.all(:select=>"id,numero,value", :order=>"value "+@direction)
      end
    end
  end

  # GET /as_values/1
  # GET /as_values/1.xml
  def show
    @as_note = AsNote.find(params[:as_note_id])
    @labels = @as_note.get_sorted_labels(@as_note)
    @numero = params[:id]

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
    @as_note = AsNote.find(params[:as_note_id])
    @labels = @as_note.get_sorted_labels(@as_note)
    @numero = params[:id]
  end

  # POST /as_values
  # POST /as_values.xml
  def create
    @as_note = AsNote.find(params[:as_note_id])
    values = params[:content]
    AsValue.save_entire_record(values)

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
    @as_note = AsNote.find(params[:as_note_id])
    @numero = params[:id]
    values = params[:content]
    AsValue.update_entire_record(@numero,values)

    respond_to do |format|
      format.html { redirect_to as_note_as_values_url(@as_note) }
      #format.html { redirect_to as_note_as_value_url(@as_note,@numero) }
      #format.xml  { render :xml => @as_value, :status => :created, :location => @as_value }
    end
  end

  # DELETE /as_values/1
  # DELETE /as_values/1.xml
  def destroy
    @as_note = AsNote.find(params[:as_note_id])
    @numero = params[:id]
    AsValue.delete_entire_record(@numero)

    respond_to do |format|
      format.html { redirect_to as_note_as_values_url(@as_note) }
      #format.xml  { head :ok }
    end
  end

end
