class AddPublickToAsnote < ActiveRecord::Migration
  def self.up
    add_column :as_notes, :public, :boolean
  end

  def self.down
    remove_column :as_notes, :public
  end
end
