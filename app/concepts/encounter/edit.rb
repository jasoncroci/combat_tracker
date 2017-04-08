class Encounter::Edit < Trailblazer::Operation
  step Macro::AdminPolicy()
  step Model( Encounter, :find_by )
  step Contract::Build( constant: Encounter::Contract::Create )
end
