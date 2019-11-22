class CreateUrlVisiteds < ActiveRecord::Migration[6.0]
  def change
    create_table :url_visiteds do |t|
      t.string :url
      t.datetime :date_of_visit
      t.datetime :end_of_visit
      t.integer :focus
      t.datetime :start_focus
      t.datetime :end_focus
      t.integer :total_focus

      t.belongs_to :horodator_schedule, index: true

      t.timestamps
    end
  end
end
