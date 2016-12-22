class AddExtraFieldToUsers < ActiveRecord::Migration[5.0]
  def change
    ## User attr
    add_column :users, :last_name, :string, null: false, default: ""
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :profil_picture, :string, default: ""
  end
end
