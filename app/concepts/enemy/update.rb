class Enemy::Update < Trailblazer::Operation
  step Nested( Enemy::Edit )
  #failure :log1!
  step Contract::Validate(key: "enemy")
  #failure :log2!
  step Contract::Persist()
  #failure :log3!

  def log1!(options)
    raise 'log1!'
  end

  def log2!(options)
    raise 'log2'
  end

  def log3!(options)
    raise 'log3!'
  end
end
