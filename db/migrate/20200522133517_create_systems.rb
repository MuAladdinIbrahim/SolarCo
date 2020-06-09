class CreateSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :systems do |t|
      t.decimal :latitude, :default => 0, :precision => 9, :scale => 6
      t.decimal :longitude, :default => 0, :precision => 9, :scale => 6
      t.integer :consumption, :default => 0
      t.boolean :backup, :default => false
      t.string :address
      t.string :city, null: false
      t.string :country, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
