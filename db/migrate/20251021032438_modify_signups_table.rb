class ModifySignupsTable < ActiveRecord::Migration[8.0]
  def change
    # Remove old columns
    remove_column :signups, :name, :string
    remove_column :signups, :email, :string
    
    # Add new admin_id column
    add_reference :signups, :admin, null: false, foreign_key: true
    
    # Add unique constraint to prevent duplicate signups
    add_index :signups, [:admin_id, :calendar_id], unique: true
  end
end
