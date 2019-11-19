class CreateHorodatorSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :horodator_schedules do |t|
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
