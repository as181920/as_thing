class PermissionRequestsController < ApplicationController

  def new
    @as_note = AsNote.find(params[:as_note_id])
    @req = @as_note.permission_requests.build
  end

  def create
    @as_note = AsNote.find(params[:as_note_id])
    @req = @as_note.permission_requests.build(params[:permission_request])
    @req.as_note_id = @as_note.id
    @req.user_id = current_user.id
    @req.current_status = "applying"

    respond_to do |format|
      if @req.save then
        format.html { redirect_to as_note_path(@as_note) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @as_note = AsNote.find(params[:as_note_id])
    @req = PermissionRequest.find(params[:id])
    @req.current_status = "closed"
    @o_user = @req.user

    #todo add ownership record when req approved
    @ownership = Ownership.new
    @ownership.as_note = @as_note
    @ownership.user = @o_user
    position_max = @o_user.ownerships.order("position desc").first
    if position_max then 
      @ownership.position = position_max.position.to_i + 1
    else
      @ownership.position = 1
    end

    if @ownership.save then
      respond_to do |format|
        if @req.save then
          format.html { redirect_to as_note_path(@as_note) }
        else
          format.html { redirect_to appliers_as_note_path(@as_note), :notice=>"error occured"}
          #format.html { render :back }
        end
      end
    else
      redirect_to applier_as_note_path(@as_note), :notice=>"ownership save failed!"
    end
  end

  def destroy
    @as_note = Relationship.find(params[:id]).fd_note

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
