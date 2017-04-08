class Character::New < Trailblazer::Operation
  step Macro::AdminPolicy()
  step Model( Character, :new )
  step Contract::Build( constant: Character::Contract::Create )
end
