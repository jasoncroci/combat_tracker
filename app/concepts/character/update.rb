class Character::Update < Trailblazer::Operation
  step Model( Character, :find_by )
  step Contract::Build( constant: Character::Contract::Create )
  step Contract::Validate(key: "character")
  step Contract::Persist()
end
