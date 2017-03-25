require 'rails_helper'

RSpec.describe Enemy::New, type: :concept do

  subject(:result) do
    Enemy::New.()
  end

  specify do
    expect( subject.success? ).to be true
  end

  specify do
    expect( subject["model"] ).to be_a Enemy
    expect( subject["contract.default"] ).to be_a Enemy::Contract::Create
  end

end
