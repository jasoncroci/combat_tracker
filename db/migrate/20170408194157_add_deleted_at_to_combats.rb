class AddDeletedAtToCombats < ActiveRecord::Migration[5.0]
  def change
    add_column :combats, :deleted_at, :datetime
    add_index :combats, :deleted_at
  end
end
