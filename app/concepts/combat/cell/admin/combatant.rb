module Combat::Cell::Admin
  class Combatant < Combat::Cell::User::Combatant
    include Cell::Erb
    property :current_hit_points

    def open_eye
      "glyphicon glyphicon-eye-open"
    end

    def closed_eye
      "glyphicon glyphicon-eye-close"
    end
  end
end
