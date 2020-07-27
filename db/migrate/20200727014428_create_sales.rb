class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.integer :value
      t.integer :change
      t.string :payment_method

      t.timestamps
    end
  end
end
