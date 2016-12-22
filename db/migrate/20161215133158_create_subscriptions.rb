class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|

      t.references :card, foreign_key: true

      t.float :amount
      t.string :duration
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
