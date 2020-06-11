class CreateTutorialsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tutorials_tags do |t|
      t.references :tutorial, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end
  end
end
