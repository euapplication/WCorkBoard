class RemoveEmailDeliver < ActiveRecord::Migration
  def up
    remove_column :users, :email_deliver
  end

  def down
    add_column :users, :email_deliver, :boolean
  end
end
