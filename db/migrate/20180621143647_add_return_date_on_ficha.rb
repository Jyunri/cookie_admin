class AddReturnDateOnFicha < ActiveRecord::Migration[5.1]
  def change
    add_column :fichas, :return_date, :date
  end
end
