class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.boolean :closed, :default => false
      t.integer :offers_count, :default => 0
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end
  end
end
