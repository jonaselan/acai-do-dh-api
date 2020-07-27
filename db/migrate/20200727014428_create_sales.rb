class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.references :deliveryman, null: true, foreign_key: { to_table: :deliverymen }
      t.decimal :value
      t.decimal :charge
      t.string :payment_method
      t.string :delivery_method
      t.decimal :delivery_fee

      t.timestamps
    end
  end
end
