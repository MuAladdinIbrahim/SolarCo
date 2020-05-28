class CreateSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :systems do |t|
      t.decimal :latitude, :default => 0, precision: 15, scale: 8
      t.decimal :longitude,:default => 0, precision: 15, scale: 8
      t.integer :consumption, :default => 0
      t.string :road
      t.string :neighbourhood
      t.string :hamlet
      t.string :city
      t.string :country
      t.references :user
      t.timestamps
    end
  end
end
