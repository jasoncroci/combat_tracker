class AddUserIdToCombats < ActiveRecord::Migration[5.0]
  def change
    add_reference :combats, :user, foreign_key: true
  end
end
