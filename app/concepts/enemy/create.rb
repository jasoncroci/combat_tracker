class Enemy::Create < Trailblazer::Operation
  step Nested( New )
  step Contract::Validate(key: "enemy")
  step Contract::Persist()
end
