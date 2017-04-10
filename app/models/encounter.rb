class Encounter < ApplicationRecord
  belongs_to :user
  has_many :enemies, -> { order(created_at: "asc") }
  scope :by_user, ->(user) { all.where(user:user) }
  accepts_nested_attributes_for :enemies, allow_destroy: true
end
