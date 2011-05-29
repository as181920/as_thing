class AsLabelsController < ApplicationController
  # GET /as_labels
  # GET /as_labels.xml
  def index
    @as_labels = AsLabel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @as_labels }
    end
  end

  # GET /as_labels/1
  # GET /as_labels/1.xml
  def show
    @as_label = AsLabel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @as_label }
    end
  end

  # GET /as_labels/new
  # GET /as_labels/new.xml
  def new
    @as_label = AsLabel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @as_label }
    end
  end

  # GET /as_labels/1/edit
  def edit
    @as_label = AsLabel.find(params[:id])
  end

  # POST /as_labels
  # POST /as_labels.xml
  def create
    @as_label = AsLabel.new(params[:as_label])

    respond_to do |format|
      if @as_label.save
        format.html { redirect_to(@as_label, :notice => 'As label was successfully created.') }
        format.xml  { render :xml => @as_label, :status => :created, :location => @as_label }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @as_label.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /as_labels/1
  # PUT /as_labels/1.xml
  def update
    @as_label = AsLabel.find(params[:id])

    respond_to do |format|
      if @as_label.update_attributes(params[:as_label])
        format.html { redirect_to(@as_label, :notice => 'As label was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @as_label.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /as_labels/1
  # DELETE /as_labels/1.xml
  def destroy
    @as_label = AsLabel.find(params[:id])
    @as_label.destroy

    respond_to do |format|
      format.html { redirect_to(as_labels_url) }
      format.xml  { head :ok }
    end
  end
end
