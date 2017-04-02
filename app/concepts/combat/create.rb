class Combat::Create < Trailblazer::Operation
  step :encounter!
  step :enemies!
  step :characters!
  step Model( Combat, :new )
  step :contract!
  step :save!


  def encounter!(options, params:, **)
    options["encounter"] = Encounter.find_by(id: params["encounter_id"])
  end

  def enemies!(options,encounter:,**)
    options["enemies"] = encounter.enemies
  end

  def characters!(options)
    options["characters"] = Character.all
  end

  def contract!(options,model:,encounter:,characters:,enemies:,**)
    options["contract.default"] =
      Combat::Contract::Create.new model, {
        encounter:encounter,
        characters: characters,
        enemies:enemies
      }
  end

  def save!(options,model:,**)
    options["contract.default"].save do |hash|
      model.data = hash
      model.save
    end
  end

end
