class ModifyRelationshipAsnoteidToFdnoteid < ActiveRecord::Migration
  def self.up
    rename_column :relationships, :as_note_id, :fd_note_id
  end

  def self.down
    rename_column :relationships, :fd_note_id, :as_note_id
  end
end
