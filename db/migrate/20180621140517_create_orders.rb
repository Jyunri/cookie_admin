class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :client_id
      t.integer :product_id
      t.integer :product_count
      t.integer :ficha_id
      t.decimal :total_price, :precision =>8, :scale => 2

      t.timestamps
    end
  end
end
