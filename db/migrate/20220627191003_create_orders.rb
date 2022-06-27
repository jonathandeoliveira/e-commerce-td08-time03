class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.decimal :total_value
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
