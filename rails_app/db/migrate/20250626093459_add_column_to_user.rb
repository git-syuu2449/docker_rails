class AddColumnToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :discarded_at, :datetime, after: :updated_at
    add_column :users, :role, :integer, null: false, default: 0, after: :email
    add_column :users, :name, :string, after: :email

    add_index :users, :role
    add_index :users, :discarded_at
  end
end
