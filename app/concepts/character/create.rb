class Character::Create < Trailblazer::Operation
  step Model( Character, :new )
  step Contract::Build( constant: Character::Contract::Create )
  step Contract::Validate(key: "character")
  step Contract::Persist()
end
