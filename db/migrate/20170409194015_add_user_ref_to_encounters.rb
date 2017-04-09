class AddUserRefToEncounters < ActiveRecord::Migration[5.0]
  def change
    add_reference :encounters, :user, foreign_key: true
  end
end
