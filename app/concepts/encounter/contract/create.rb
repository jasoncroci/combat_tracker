module Encounter::Contract
  class Create < Reform::Form
    property :name
    property :challenge_rating
    property :experience_points

    validates :name, presence: true
    validates :challenge_rating, presence: true, numericality: true
    validates :experience_points, presence: true, numericality: true
  end
end
