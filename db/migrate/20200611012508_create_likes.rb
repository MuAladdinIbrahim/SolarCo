class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :tutorial, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :islike

      t.timestamps
    end
  end
end
