class AddDefaultPointsToUsers < ActiveRecord::Migration
  def up
    change_column_default :users, :points, 1000
  end

  def down
    change_column_default :users, :points, nil
  end  
end
