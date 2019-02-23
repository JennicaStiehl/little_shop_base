class ChangeOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_reference(:addresses, :address, foreign_key: {to_table: :order_items})
  end
end
