class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.string :move
      t.string :time
      t.references :user, index: true

      t.timestamps
    end
  end
end
