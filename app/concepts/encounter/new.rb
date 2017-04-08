class Encounter::New < Trailblazer::Operation
  step Macro::AdminPolicy()
  step Model( Encounter, :new )
  step Contract::Build( constant: Encounter::Contract::Create )
end
