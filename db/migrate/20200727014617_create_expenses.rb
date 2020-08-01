class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.integer :value, :decimal, precision: 5, scale: 2
      t.integer :kind #

      t.timestamps
    end
  end
end
