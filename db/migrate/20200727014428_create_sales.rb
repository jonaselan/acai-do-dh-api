class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.references :deliveryman, null: true, foreign_key: { to_table: :deliverymen }
      t.decimal :value, default: 0, precision: 5, scale: 2
      t.decimal :charge, default: 0, precision: 5, scale: 2
      t.string :payment_method
      t.string :delivery_method
      t.decimal :delivery_fee, precision: 5, scale: 2
      t.boolean :paid, default: false
      t.boolean :receiver, default: false

      t.timestamps
    end
  end
end
