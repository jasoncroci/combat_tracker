class Encounter < ApplicationRecord
  has_many :enemies, -> { order(created_at: "asc") }
end
