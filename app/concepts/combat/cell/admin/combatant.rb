module Combat::Cell::Admin
  class Combatant < Combat::Cell::User::Combatant
    include Cell::Erb
    property :current_hit_points
  end
end
