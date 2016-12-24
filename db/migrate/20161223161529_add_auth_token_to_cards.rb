class AddAuthTokenToCards < ActiveRecord::Migration[5.0]
  def self.up
    add_column :cards, :auth_token, :string
  end

  def self.down
    remove_column :cards, :auth_token, :string
  end
end
