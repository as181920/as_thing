require "csv"
class AsValuesController < ApplicationController
  #before_filter :require_owned
  before_filter :check_permission

  # GET /as_values
  # GET /as_values.xml
  def index
    @as_note = AsNote.find(params[:as_note_id])
    @labels = @as_note.get_visible_labels(@as_note)
    #TODO ..when label is nil, optimize the handle method, consider use self_defined validation method
    unless @as_note.as_labels.first
      redirect_to(@as_note, :notice =>'Should add labels first.')
      return
    else
      @sort = AsValue.get_sort_label_id(@as_note,params[:sort])
      @direction = params[:direction] == "asc" ? "desc" : "asc"
      @direction_static = params[:direction]
      @labels_select = @labels.collect {|l| [l.name, l.id]}
      @labels_select << ["No.","numero"]
      @label_selected = params[:label]
      @search = params[:search]
      @page_number = params[:page]

      @label_selected_array = AsValue.get_label_selected_array(@label_selected)

      #TODO:performance to be improved 
      @l_values_page, @records_count = AsValue.get_lvalues_and_count(@as_note,@sort,@direction,@label_selected,@search,@page_number)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.csv do
        #csv_data = FasterCSV.generate do |csv|
        csv_data = CSV.generate do |csv|
          th = ["No."] + @as_note.as_labels.collect {|lb| lb.name }
          csv << th

          lvalues_all = AsValue.get_lvalues_all(@as_note,@sort,@direction,@label_selected,@search)
          lvalues_all.each do |lv|
            tr = [lv.numero]
            @as_note.as_labels.each do |lb|
              cv = AsValue.current_value(lv.numero,lb.id)
              if lb.label_format = "Text" then
                cv = Nokogiri::HTML.parse(cv).content
              end
              tr += [cv]
            end
            csv << tr
          end
        end
        render :text=>csv_data
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
    #TODO: modify get_sorted_labels method
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
    @sort = params[:sort]
    @direction = params[:direction]
    @search = params[:search]
    @label = params[:label]
    @page = params[:page]
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
    @sort = params[:sort]
    @direction = params[:direction]
    @search = params[:search]
    @label = params[:label]
    @page = params[:page]
    values = params[:content]
    AsValue.update_entire_record(@numero,values)

    respond_to do |format|
      format.html { redirect_to(:action=>:index,:sort=>@sort,:direction=>@direction,:search=>@search,:label=>@label,:page=>@page) }
      #format.html { redirect_to as_note_as_values_url(@as_note) }
      #format.html { redirect_to as_note_as_value_url(@as_note,@numero) }
      #format.xml  { render :xml => @as_value, :status => :created, :location => @as_value }
    end
  end

  # DELETE /as_values/1
  # DELETE /as_values/1.xml
  def destroy
    @as_note = AsNote.find(params[:as_note_id])
    @numero = params[:id]
    @sort = params[:sort]
    @direction = params[:direction]
    @search = params[:search]
    @label = params[:label]
    @page = params[:page]
    AsValue.delete_entire_record(@numero)

    respond_to do |format|
      #format.html { redirect_to as_note_as_values_url(@as_note) }
      format.html { redirect_to(:action=>:index, :sort=>@sort,:direction=>@direction,:search=>@search,:label=>@label,:page=>@page) }
      #format.xml  { head :ok }
    end
  end

end
