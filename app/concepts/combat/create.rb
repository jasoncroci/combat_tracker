class Combat::Create < Trailblazer::Operation
  include Rails.application.routes.url_helpers

  step Macro::AdminPolicy()
  step :encounter!
  step :enemies!
  step :characters!
  step Model( Combat, :new )
  step :contract!
  step :start_combat!
  step :save!
  success :broadcast!

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

  def start_combat!(options)
    options["contract.default"].start_combat!
  end

  def save!(options,model:,current_user:,**)
    options["contract.default"].save do |hash|
      model.data = hash
      model.user = current_user
      model.save
    end
  end

  def broadcast!(options,**)
    ActionCable.server.broadcast "waiting_room_channel", url: current_combat_path
  end

end
