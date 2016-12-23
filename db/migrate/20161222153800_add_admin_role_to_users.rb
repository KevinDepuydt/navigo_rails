class AddAdminRoleToUsers < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :admin, :boolean, default: false
  end

  def self.down
    remove_column :users, :admin, :boolean
  end
end
