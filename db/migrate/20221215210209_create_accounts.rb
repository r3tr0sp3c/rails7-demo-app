class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :vat
      t.string :city
      t.integer :zipcode
      t.string :address

      t.timestamps
    end
  end
end
