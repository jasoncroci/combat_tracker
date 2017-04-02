class CreateCombats < ActiveRecord::Migration[5.0]
  def change
    create_table :combats do |t|
      t.json :data
      t.timestamps
    end
  end
end
