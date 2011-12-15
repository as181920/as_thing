class CreateFollowships < ActiveRecord::Migration
  def self.up
    create_table :followships do |t|
      t.integer :followed_id
      t.integer :follower_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :followships
  end
end
