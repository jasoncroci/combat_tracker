class Combat::Update < Trailblazer::Operation
  step Macro::AdminPolicy()
  step Model( Combat, :find_by )
  step Contract::Build( constant: Combat::Contract::Create )
  step Contract::Validate(key: "combat")
  step :update!
  success :broadcast!

  def update!(options,model:,**)
    options["contract.default"].save do |hash|
      model.update_attribute(:data, hash)
    end
  end

  def broadcast!(options,**)
    ActionCable.server.broadcast "combat_channel", options["contract.default"].to_nested_hash
  end
end
