class AddWinPercentageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :win_percentage, :float
  end
end
