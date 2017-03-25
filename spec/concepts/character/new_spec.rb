require 'rails_helper'

RSpec.describe Character::New, type: :concept do

  subject(:result) do
    Character::New.()
  end

  specify do
    expect( subject.success? ).to be true
  end

  specify do
    expect( subject["model"] ).to be_a Character
    expect( subject["contract.default"] ).to be_a Character::Contract::Create
  end

end
