class AddAuthTokenToUsers < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :auth_token, :string
  end

  def self.down
    remove_column :users, :auth_token, :string
  end
end
