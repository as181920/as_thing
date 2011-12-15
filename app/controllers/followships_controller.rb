class FollowshipsController < ApplicationController
  # GET /followships
  # GET /followships.xml
  def index
    @followships = Followship.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @followships }
    end
  end

  # GET /followships/1
  # GET /followships/1.xml
  def show
    @followship = Followship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @followship }
    end
  end

  # GET /followships/new
  # GET /followships/new.xml
  def new
    @followship = Followship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @followship }
    end
  end

  # GET /followships/1/edit
  def edit
    @followship = Followship.find(params[:id])
  end

  # POST /followships
  # POST /followships.xml
  def create
    @followship = Followship.new(params[:followship])

    respond_to do |format|
      if @followship.save
        format.html { redirect_to(@followship, :notice => 'Followship was successfully created.') }
        format.xml  { render :xml => @followship, :status => :created, :location => @followship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @followship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /followships/1
  # PUT /followships/1.xml
  def update
    @followship = Followship.find(params[:id])

    respond_to do |format|
      if @followship.update_attributes(params[:followship])
        format.html { redirect_to(@followship, :notice => 'Followship was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @followship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /followships/1
  # DELETE /followships/1.xml
  def destroy
    @followship = Followship.find(params[:id])
    @followship.destroy

    respond_to do |format|
      format.html { redirect_to(followships_url) }
      format.xml  { head :ok }
    end
  end
end
