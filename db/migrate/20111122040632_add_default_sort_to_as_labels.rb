class AddDefaultSortToAsLabels < ActiveRecord::Migration
  def self.up
    add_column :as_labels, :default_sort, :boolean
  end

  def self.down
    remove_column :as_labels, :default_sort
  end
end
