class CreateOfferRates < ActiveRecord::Migration[6.0]
  def change
    create_table :offer_rates do |t|
      t.integer :rate
      t.references :user, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
