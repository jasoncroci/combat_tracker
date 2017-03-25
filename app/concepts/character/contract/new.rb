class Character::New < Trailblazer::Operation
  step Model( Character, :new )
  step Contract::Build( constant: Character::Contract::Create )
end
