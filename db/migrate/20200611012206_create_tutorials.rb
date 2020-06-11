class CreateTutorials < ActiveRecord::Migration[6.0]
  def change
    create_table :tutorials do |t|
      t.string :title
      t.text :body
      t.references :contractor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
