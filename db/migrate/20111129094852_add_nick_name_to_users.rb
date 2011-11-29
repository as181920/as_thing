class AddNickNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :nick_name, :string
  end

  def self.down
    remove_column :users, :nick_name
  end
end
