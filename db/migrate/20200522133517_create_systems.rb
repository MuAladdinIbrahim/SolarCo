class CreateSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :systems do |t|
      t.decimal :latitude, :default => 0, precision: 10, scale: 3
      t.decimal :longitude,:default => 0, precision: 10, scale: 3
      t.integer :electricity_bill, :default => 0
      t.string :city
      t.string :country
      t.references :user
      t.timestamps
    end
  end
end
