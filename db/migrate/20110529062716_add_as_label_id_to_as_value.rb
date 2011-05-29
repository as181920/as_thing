class AddAsLabelIdToAsValue < ActiveRecord::Migration
  def self.up
    add_column :as_values, :as_label_id, :integer
  end

  def self.down
    remove_column :as_values, :as_label_id
  end
end
