class CreateEncounters < ActiveRecord::Migration[5.0]
  def change
    create_table :encounters do |t|
      t.string :name
      t.integer :challenge_rating, default: 0
      t.integer :experience_points, default: 0
      t.timestamps
    end
  end
end
