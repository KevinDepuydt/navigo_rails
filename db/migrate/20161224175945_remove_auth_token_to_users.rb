class RemoveAuthTokenToUsers < ActiveRecord::Migration[5.0]
  def self.up
    remove_column :users, :auth_token, :string
  end

  def self.down
    add_column :users, :auth_token, :string
  end
end
