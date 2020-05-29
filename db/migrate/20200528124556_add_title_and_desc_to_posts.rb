class AddTitleAndDescToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :title, :string, null: false 
    add_column :posts, :description, :text, null: false 
  end
end
