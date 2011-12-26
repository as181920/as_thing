class AddMessageAndStatusTo_permissionRequests < ActiveRecord::Migration
  def self.up
    add_column :permission_requests, :message_text, :text
    add_column :permission_requests, :current_status, :string
  end

  def self.down
    remove_column :permission_requests, :message_text
    remove_column :permission_requests, :current_status
  end
end
