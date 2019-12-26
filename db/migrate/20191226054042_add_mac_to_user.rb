class AddMacToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mac, :string
  end
end
