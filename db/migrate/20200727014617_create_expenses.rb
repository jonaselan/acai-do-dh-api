class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.decimal :value, precision: 5, scale: 2
      t.string :kind
      t.text :description

      t.timestamps
    end
  end
end
