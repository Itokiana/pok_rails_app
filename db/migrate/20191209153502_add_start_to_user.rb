class AddStartToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :start, :datetime
  end
end
