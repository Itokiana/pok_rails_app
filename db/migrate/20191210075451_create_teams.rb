class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name

      t.timestamps
    end

    Team.create do |t|
      t.name = "Aucun"
    end
  end
end
