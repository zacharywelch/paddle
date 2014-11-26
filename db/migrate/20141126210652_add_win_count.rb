class AddWinCount < ActiveRecord::Migration
  def self.up
    add_column :users, :win_count, :integer, :default => 0

    User.reset_column_information
    User.find(:all).each do |u|
      User.update_counters u.id, :win_count => u.wins.length
    end
  end

  def self.down
    remove_column :users, :win_count
  end
end
