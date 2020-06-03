class CreateSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :systems do |t|
      t.decimal :latitude, :default => 0, :precision => 17, :scale => 14
      t.decimal :longitude, :default => 0, :precision => 17, :scale => 14
      t.integer :consumption, :default => 0
      t.string :city, null: false
      t.string :country, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
