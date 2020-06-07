class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string, null: false, default: 'username'
    add_column :contractors, :username, :string, null: false, default: 'username'
  end
end
