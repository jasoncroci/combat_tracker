class Combat::Update < Trailblazer::Operation
  step Macro::AdminPolicy()
  step Model( Combat, :find_by )
  step Contract::Build( constant: Combat::Contract::Create )
  step Contract::Validate(key: "combat")
  step :update!
  step :broadcaster!
  success :broadcast!

  def update!(options,model:,**)
    options["contract.default"].save do |hash|
      model.update_attribute(:data, hash)
    end
  end

  def broadcaster!(options,current_user:,**)
    options["broadcaster"] = Combat::Broadcaster::Update.(options)
  end

  def broadcast!(options,**)
    ActionCable.server.broadcast "combat_channel", options["broadcaster"]
  end
end
