class CreateSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :systems do |t|
      t.string :type
      t.integer :latitude, :default => 0
      t.integer :longitude,:default => 0
      t.integer :electricity_bill, :default => 0
      t.string :city
      t.references :user
      t.timestamps
    end
  end
end
