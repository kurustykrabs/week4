class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.string :issuer
      t.decimal :total_price
      t.decimal :discount

      t.timestamps
    end
  end
end
