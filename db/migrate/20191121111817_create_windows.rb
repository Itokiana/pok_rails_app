class CreateWindows < ActiveRecord::Migration[6.0]
  def change
    create_table :windows do |t|
      t.string :title
      t.string :platform
      t.integer :x
      t.integer :y
      t.integer :width_screen
      t.integer :height_screen
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :total_focus

      t.timestamps
    end
  end
end
