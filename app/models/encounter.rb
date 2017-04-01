class Encounter < ApplicationRecord
  has_many :enemies, -> { order(created_at: "asc") }

  def characters
    @characters ||= Character.all
  end
end
