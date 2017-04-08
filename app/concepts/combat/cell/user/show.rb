module Combat::Cell::User
  class Show < Trailblazer::Cell
    include Cell::Erb
    property :current_round
    property :combatants
  end
end
