class CreateAsValues < ActiveRecord::Migration
  def self.up
    create_table :as_values do |t|
      t.text :value
      t.integer :numero

      t.timestamps
    end
  end

  def self.down
    drop_table :as_values
  end
end
