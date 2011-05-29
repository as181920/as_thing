class AddAsNoteIdToAsLabel < ActiveRecord::Migration
  def self.up
    add_column :as_labels, :as_note_id, :integer
  end

  def self.down
    remove_column :as_labels, :as_note_id
  end
end
