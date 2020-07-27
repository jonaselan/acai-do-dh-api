class CreateDeliverymen < ActiveRecord::Migration[6.0]
  def change
    create_table :deliverymen do |t|
      t.string :name
      t.string :avatar

      t.timestamps
    end
  end
end
