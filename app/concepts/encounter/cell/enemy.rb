module Encounter::Cell
  class Enemy < Trailblazer::Cell
    include Cell::Erb
    property :id
    property :name
    property :hit_points
    property :armor_class

    def encounter
      options[:encounter]
    end
  end
end
