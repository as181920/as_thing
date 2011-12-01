class RmUnusedColumnsOfLabels < ActiveRecord::Migration
  def self.up
    remove_column :as_labels, :min_length
    remove_column :as_labels, :max_length
    remove_column :as_labels, :regexp
    remove_column :as_labels, :is_filter
    remove_column :as_labels, :editable
    remove_column :as_labels, :unsearchable
  end

  def self.down
    add_column :as_labels, :min_length, :integer
    add_column :as_labels, :max_length, :integer
    add_column :as_labels, :regexp, :string
    add_column :as_labels, :is_filter, :boolean
    add_column :as_labels, :editable, :boolean
    add_column :as_labels, :unsearchable, :boolean, :default=>false
  end
end
