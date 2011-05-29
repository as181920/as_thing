class CreateAsNotes < ActiveRecord::Migration
  def self.up
    create_table :as_notes do |t|
      t.string :name
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :as_notes
  end
end
