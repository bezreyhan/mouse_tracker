class AddSaltToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salt, :text
  end
end
