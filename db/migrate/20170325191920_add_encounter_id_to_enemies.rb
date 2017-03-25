class AddEncounterIdToEnemies < ActiveRecord::Migration[5.0]
  def change
    add_column :enemies, :encounter_id, :integer
  end
end
