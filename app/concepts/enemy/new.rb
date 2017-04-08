class Enemy::New < Trailblazer::Operation
  step Macro::AdminPolicy()
  step :encounter!
  step :model!
  step Contract::Build( constant: Enemy::Contract::Create )

  def encounter!(options, params:, **)
    options["parent_model"] = Encounter.find_by(id: params["encounter_id"])
  end

  def model!(options, parent_model:, **)
    options["model"] = parent_model.enemies.new
  end
end
