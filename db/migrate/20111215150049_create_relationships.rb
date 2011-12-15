class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :as_note_id
      t.integer :follower_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
