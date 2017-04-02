module Combat::Contract
  class Create < Reform::Form
    property :current_round, default: 1, virtual: true

    property :encounter, populate_if_empty: Encounter, virtual: true do
      property :name
      property :challenge_rating
      property :experience_points
    end

    collection :enemies, populate_if_empty: Enemy, default: [], virtual: true do
      property :name
      property :hit_points
      property :armor_class
      # Virtual Fields
      property :current_hit_points, virtual: true, default: -> { self.hit_points }
      property :initiative, virtual: true, default: 0
    end

    collection :characters, populate_if_empty: Character, default: [], virtual: true do
      property :name
      property :hit_points
      property :armor_class
      # Virtual Fields
      property :current_hit_points, virtual: true, default: -> { self.hit_points }
      property :initiative, virtual: true, default: 0
    end
  end
end
