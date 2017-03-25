class Enemy::Create < Trailblazer::Operation
  step Model( Enemy, :new )
  step Contract::Build( constant: Enemy::Contract::Create )
  step Contract::Validate(key: "enemy")
  step Contract::Persist()
end
