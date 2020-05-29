class CreateSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :systems do |t|
      t.decimal :latitude, :default => 0, :precision => 10, :scale => 8
      t.decimal :longitude,:default => 0, :precision => 10, :scale => 8
      t.integer :consumption, :default => 0
      t.string :road
      t.string :neighbourhood
      t.string :hamlet
      t.string :city, null: false
      t.string :country, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
