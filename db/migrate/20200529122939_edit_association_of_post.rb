class EditAssociationOfPost < ActiveRecord::Migration[6.0]
  def change
    change_table :posts do |t|
      t.remove_references :post
      t.references :system, null: false, foreign_key: true    end
  end
end
