class RemoveWinPercentageFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :win_percentage
  end
end
