class Encounter::Create < Trailblazer::Operation
  step Macro::AdminPolicy()
  step Model( Encounter, :new )
  step Contract::Build( constant: Encounter::Contract::Create )
  step Contract::Validate(key: "encounter")
  step :user!
  step Contract::Persist()

  def user!(options,model:,current_user:,**)
    model.user = current_user
  end
end
