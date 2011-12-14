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
      redirect_to(as_note_as_labels_path(@as_note), :notice =>'Should add columns first.')
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
          th = ["No."] + @as_note.get_sorted_labels(@as_note).collect {|lb| lb.name }
          csv << th

          lvalues_all = AsValue.get_lvalues_all(@as_note,@sort,@direction,@label_selected,@search)
          lvalues_all.each do |lv|
            tr = [lv.numero]
            @as_note.get_sorted_labels(@as_note).each do |lb|
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
    @values = params[:content]
    if AsValue.save_entire_record(@values) then
      redirect_to as_note_as_values_url(@as_note)
    else
      #TODO: keep inputed @values after check validation and redirect
      #redirect_to(new_as_note_as_value_path(@as_note), :notice => 'some data not valid,please check again!')
      #redirect_to :back, :notice => 'some data not valid,please check again!'
      render(:text => "some data not valid,please back to last page and check again!")
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
    @values = params[:content]
    if AsValue.update_entire_record(@numero,@values) then
      redirect_to(:action=>:index,:sort=>@sort,:direction=>@direction,:search=>@search,:label=>@label,:page=>@page)
    else
      #TODO: add some error notice information
      #redirect_to(:action=>:edit, :sort=>@sort,:direction=>@direction,:search=>@search,:label=>@label,:page=>@page)
      render(:text => "some data not valid,please back to last page and check again!")
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
