class AsValuesController < ApplicationController
  # GET /as_values
  # GET /as_values.xml
  def index
    @as_values = AsValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @as_values }
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
    @as_value = AsValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @as_value }
    end
  end

  # GET /as_values/1/edit
  def edit
    @as_value = AsValue.find(params[:id])
  end

  # POST /as_values
  # POST /as_values.xml
  def create
    @as_value = AsValue.new(params[:as_value])

    respond_to do |format|
      if @as_value.save
        format.html { redirect_to(@as_value, :notice => 'As value was successfully created.') }
        format.xml  { render :xml => @as_value, :status => :created, :location => @as_value }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @as_value.errors, :status => :unprocessable_entity }
      end
    end
  end

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
