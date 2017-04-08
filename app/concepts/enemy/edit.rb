class Enemy::Edit < Trailblazer::Operation
  step Macro::AdminPolicy()
  step :encounter!
  step Model( Enemy, :find_by )
  step Contract::Build( constant: Enemy::Contract::Create )

  def encounter!(options, params:, **)
    options["parent_model"] = Encounter.find_by(id: params["encounter_id"])
  end
end
