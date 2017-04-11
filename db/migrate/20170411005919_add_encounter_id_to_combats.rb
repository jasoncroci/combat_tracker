class AddEncounterIdToCombats < ActiveRecord::Migration[5.0]
  def change
    add_reference :combats, :encounter, index: true, foreign_key: true
  end
end
