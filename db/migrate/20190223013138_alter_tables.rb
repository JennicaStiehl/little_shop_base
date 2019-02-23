class AlterTables < ActiveRecord::Migration[5.1]
  def change
    remove_column :addresses, :address_id
    add_reference(:users, :address, foreign_key: {to_table: :addresses})

  end
end
