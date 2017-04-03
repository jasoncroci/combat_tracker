class Combat::Update < Trailblazer::Operation
  step Model( Combat, :find_by )
  step Contract::Build( constant: Combat::Contract::Create )
  step Contract::Validate(key: "combat")
  step :update!

  def update!(options,model:,**)
    options["contract.default"].save do |hash|
      model.update_attribute(:data, hash)
    end
  end
end
