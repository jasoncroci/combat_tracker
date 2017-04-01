class Encounter::Create < Trailblazer::Operation
  step Model( Encounter, :new )
  step Contract::Build( constant: Encounter::Contract::Create )
  step Contract::Validate(key: "encounter")
  step Contract::Persist()
end