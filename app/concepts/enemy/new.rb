class Enemy::New < Trailblazer::Operation
  step Model( Enemy, :new )
  step Contract::Build( constant: Enemy::Contract::Create )
end
