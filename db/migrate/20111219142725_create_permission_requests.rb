class CreatePermissionRequests < ActiveRecord::Migration
  def self.up
    create_table :permission_requests do |t|
      t.integer :as_note_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :permission_requests
  end
end
