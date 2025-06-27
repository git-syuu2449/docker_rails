class AddColumnToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :discarded_at, :datetime
    add_column :users, :role, :enum

    add_index :users, :role
    add_index :users, :discarded_at
  end
end
