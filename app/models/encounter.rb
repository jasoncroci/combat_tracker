class Encounter < ApplicationRecord
  has_many :enemies, -> { order(created_at: "asc") }
  belongs_to :user
end
