class CreateOwnerships < ActiveRecord::Migration
  def self.up
    create_table :ownerships do |t|
      t.integer :as_note_id
      t.integer :user_id
      t.integer :position
      t.datetime :created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :ownerships
  end
end
