class AddGenderToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :gender, :integer, default: 0
  end
end
