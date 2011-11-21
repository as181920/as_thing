class DeletePositionOfAsnotes < ActiveRecord::Migration
  def self.up
    remove_column :as_notes, :position
  end

  def self.down
    add_column :as_notes, :position, :integer
  end
end
