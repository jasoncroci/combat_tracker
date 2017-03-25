class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :hit_points, default: 0
      t.integer :armor_class, default: 0
      t.timestamps
    end
  end
end
