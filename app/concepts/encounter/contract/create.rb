module Encounter::Contract
  class Create < Reform::Form
    property :name
    property :challenge_rating
    property :experience_points

    collection :enemies do
      property :id
      property :name
      property :armor_class
      property :hit_points
    end

    validates :name, presence: true
    validates :challenge_rating, presence: true, numericality: true
    validates :experience_points, presence: true, numericality: true
  end
end
