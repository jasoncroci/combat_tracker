class AddInitiativeBonusToEnemies < ActiveRecord::Migration[5.0]
  def change
    add_column :enemies, :initiative_bonus, :integer, default: 0
  end
end
