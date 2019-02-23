class CreateAddress < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :default?
      t.boolean :active?
      t.integer :nickname
      t.boolean :shipped_to?

      t.timestamps
    end
  end
end
