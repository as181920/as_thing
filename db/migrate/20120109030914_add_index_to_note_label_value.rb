class AddIndexToNoteLabelValue < ActiveRecord::Migration
  def self.up
    add_index :as_notes,  :id
    add_index :as_labels, :as_note_id
    add_index :as_values, [:numero, :as_label_id], :unique => true, :name => 'value_index'
  end

  def self.down
    remove_index :as_notes,  :column=>"id"
    remove_index :as_labels, :column=>"as_note_id"
    remove_index :as_values, :name=>"value_index"
  end
end
