class ChangeOrderItemTable < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :addresses, column: "address_id"
    add_reference(:order_items, :address, foreign_key: {to_table: :addresses})
  end
end
