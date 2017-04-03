class Combat::Show < Trailblazer::Operation
  step Model( Combat, :find_by )
  step Contract::Build( constant: Combat::Contract::Create )
  step :prepopulate!

  def prepopulate!(options,model:,**)
    options["contract.default"].deserialize(model.data)
  end
end
