class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :quantity
      t.string :name
      t.decimal :unit_price
      t.references :receipt, foreign_key: true

      t.timestamps
    end
  end
end
