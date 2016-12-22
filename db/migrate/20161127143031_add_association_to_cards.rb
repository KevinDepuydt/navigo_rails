class AddAssociationToCards < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :user, index: true, optional: true
  end
end
