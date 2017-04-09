class Encounter::Create < Trailblazer::Operation
  step Macro::AdminPolicy()
  step Model( Encounter, :new )
  step Contract::Build( constant: Encounter::Contract::Create )
  step Contract::Validate(key: "encounter")
  step :save!

  def save!(options,model:,current_user:,**)
    options["contract.default"].save do |hash|
      model.user = current_user
      model.save(hash)
    end
  end
end
