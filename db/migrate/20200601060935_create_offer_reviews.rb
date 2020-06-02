class CreateOfferReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :offer_reviews do |t|
      t.text :review
      t.references :contractor, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
