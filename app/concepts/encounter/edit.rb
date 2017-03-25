class Encounter::Edit < Trailblazer::Operation
  step Model( Encounter, :find_by )
  step Contract::Build( constant: Encounter::Contract::Create )
end
