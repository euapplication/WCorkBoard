class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :user_id
      t.string :title
      t.string :detail
      t.integer :x
      t.integer :y
      t.string :color_hex

      t.timestamps
    end
  end
end
