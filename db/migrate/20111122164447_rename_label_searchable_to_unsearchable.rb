class RenameLabelSearchableToUnsearchable < ActiveRecord::Migration
  def self.up
    remove_column :as_labels, :searchable
    change_table :as_labels do |t|
      t.boolean :unsearchable, :default => false
    end
  end

  def self.down
    remove_column :as_labels, :unsearchable
    change_table :as_labels do |t|
      t.boolean :searchable
    end
  end
end

class UpdateDefaultSortAsFalseLabels < ActiveRecord::Migration
  def self.up
    remove_column :as_labels, :default_sort
    change_table :as_labels do |t|
      t.boolean :default_sort, :default => false
    end
    AsLabel.update_all ["default_sort = ?", nil]
  end

  def self.down
    remove_column :as_labels, :default_sort
    change_table :as_labels do |t|
      t.boolean :default_sort
    end
  end
end
