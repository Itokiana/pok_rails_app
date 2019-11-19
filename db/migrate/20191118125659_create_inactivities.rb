class CreateInactivities < ActiveRecord::Migration[6.0]
  def change
    create_table :inactivities do |t|
      t.belongs_to :horodator_schedule, index: true

      t.timestamps
    end
  end
end
