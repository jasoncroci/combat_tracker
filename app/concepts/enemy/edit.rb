class Enemy::Edit < Trailblazer::Operation
  step Model( Enemy, :find_by )
  step Contract::Build( constant: Enemy::Contract::Create )
end
