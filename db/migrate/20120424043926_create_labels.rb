class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :user_id
      t.string :title
      t.string :detail
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
