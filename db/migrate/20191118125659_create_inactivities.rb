class CreateInactivities < ActiveRecord::Migration[6.0]
  def change
    create_table :inactivities do |t|
      t.integer :mouse_x
      t.integer :mouse_y
      t.datetime :since
      t.integer :total
      t.belongs_to :horodator_schedule, index: true

      t.timestamps
    end
  end
end
