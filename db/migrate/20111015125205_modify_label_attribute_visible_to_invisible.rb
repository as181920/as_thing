class ModifyLabelAttributeVisibleToInvisible < ActiveRecord::Migration
  def self.up
    remove_column :as_labels, :visible
    change_table :as_labels do |t|
      t.boolean :invisible, :default => false
    end
  end

  def self.down
    rename_column :as_labels, :invisible, :visible
  end
end
