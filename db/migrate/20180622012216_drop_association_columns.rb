class DropAssociationColumns < ActiveRecord::Migration[5.1]
  def change
		remove_column :orders, :client_id
  end
end
