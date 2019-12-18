class CreateTimeChecks < ActiveRecord::Migration[6.0]
  def change
    create_table :time_checks do |t|
      t.integer :application
      t.integer :inactivity
      t.integer :inactivity_part

      t.timestamps
    end
  end
end
