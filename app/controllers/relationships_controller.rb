class RelationshipsController < ApplicationController
  def create
    @as_note = AsNote.find(params[:relationship][:fd_note_id])
    current_user.note_follow!(@as_note)

    respond_to do |format|
      format.html { redirect_to public_as_notes_path }
      format.js
    end
  end

  def destroy
    @as_note = Relationship.find(params[:id]).fd_note
    current_user.note_unfollow!(@as_note)

    respond_to do |format|
      format.html { redirect_to public_as_notes_path }
      format.js
    end
  end
end
