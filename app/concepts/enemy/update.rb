class Enemy::Update < Trailblazer::Operation
  step Nested( Enemy::Edit )
  step Contract::Validate(key: "enemy")
  step Contract::Persist()
end
