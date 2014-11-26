class AddLossCount < ActiveRecord::Migration
  def self.up
    add_column :users, :loss_count, :integer, :default => 0

    User.reset_column_information
    User.find(:all).each do |u|
      User.update_counters u.id, :loss_count => u.losses.length
    end
  end

  def self.down
    remove_column :users, :loss_count
  end
end
