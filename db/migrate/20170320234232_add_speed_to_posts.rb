class AddSpeedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :speed, :integer
  end
end
