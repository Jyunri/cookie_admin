class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.integer :rg
      t.integer :cpf
      t.integer :phone
      t.string :address
      t.string :neighborhood
      t.string :city

      t.timestamps
    end
  end
end
