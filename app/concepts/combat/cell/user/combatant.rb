module Combat::Cell::User
  class Combatant < Trailblazer::Cell
    include Cell::Erb

    property :identity
    property :initiative
    property :name
    property :armor_class

    def character?
      model.model.is_a?(Character)
    end

    def combatant_class_name
      character? ? "character" : "enemy"
    end

    def current_hit_points
      character? ? model.current_hit_points : "***"
    end

  end
end
