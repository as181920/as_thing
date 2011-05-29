class CreateAsLabels < ActiveRecord::Migration
  def self.up
    create_table :as_labels do |t|
      t.string :name
      t.text :comment
      t.string :label_format
      t.text :possible_values
      t.integer :min_length
      t.integer :max_length
      t.string :regexp
      t.boolean :is_required
      t.boolean :is_filter
      t.integer :position
      t.boolean :searchable
      t.text :default_value
      t.boolean :editable
      t.boolean :visible

      t.timestamps
    end
  end

  def self.down
    drop_table :as_labels
  end
end
