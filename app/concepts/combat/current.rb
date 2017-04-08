class Combat::Current < Trailblazer::Operation
  step :combat!
  step Contract::Build( constant: Combat::Contract::Create )
  step :prepopulate!

  def combat!(options)
    options["model"] = Combat.last
  end

  def prepopulate!(options,model:,**)
    options["contract.default"].deserialize(model.data)
  end
end
