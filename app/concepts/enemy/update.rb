class Enemy::Update < Trailblazer::Operation
  step Model( Enemy, :find_by )
  step Contract::Build( constant: Enemy::Contract::Create )
  step Contract::Validate(key: "enemy")
  step Contract::Persist()
end
