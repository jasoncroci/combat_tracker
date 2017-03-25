class Character::Edit < Trailblazer::Operation
  step Model( Character, :find_by )
  step Contract::Build( constant: Character::Contract::Create )
end
