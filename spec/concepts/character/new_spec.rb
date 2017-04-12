require 'rails_helper'

RSpec.describe Character::New, type: :concept do

  let(:current_user){ build(:admin) }

  subject(:result) do
    Character::New.({}, "current_user" => current_user)
  end

  context "policy violation" do

    let(:current_user){ build(:user) }

    subject(:result) do
      Character::New.()
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  specify do
    expect( subject.success? ).to be true
  end

  specify do
    expect( result["model"] ).to be_a Character
    expect( result["contract.default"] ).to be_a Character::Contract::Create
  end

end
