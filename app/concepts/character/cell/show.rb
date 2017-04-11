module Character::Cell
  class Show < Trailblazer::Cell
    include Cell::Erb
    property :id
    property :name
    property :hit_points
    property :armor_class
  end
end
