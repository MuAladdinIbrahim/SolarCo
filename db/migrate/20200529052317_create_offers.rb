class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :proposal
      t.integer :price
      t.integer :status, default: 1
      t.references :contractor, null: true, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
