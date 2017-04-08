class Encounter::Update < Trailblazer::Operation
  step Macro::AdminPolicy()
  step Model( Encounter, :find_by )
  step Contract::Build( constant: Encounter::Contract::Create )
  step Contract::Validate(key: "encounter")
  step Contract::Persist()
end
