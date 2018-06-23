class CreateFichas < ActiveRecord::Migration[5.1]
  def change
    create_table :fichas do |t|
      t.integer :client_id

      t.timestamps
    end
  end
end
