class AddTimeToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :time, :datetime
  end
end
