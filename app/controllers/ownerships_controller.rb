class OwnershipsController < ApplicationController

  def destroy
    @ownership = Ownership.find params[:id]
    position_deleted = @ownership.position.to_i
    current_user.ownerships.update_all("position = position - 1", "position > #{position_deleted}")
    @ownership.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
