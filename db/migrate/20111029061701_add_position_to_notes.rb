class AddPositionToNotes < ActiveRecord::Migration
  def self.up
    add_column :as_notes, :position, :integer
  end

  def self.down
    remove_column :as_notes, :position
  end
end
