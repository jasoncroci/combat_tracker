require 'rails_helper'

RSpec.describe Character::New, type: :concept do

  let(:current_user){ User.new(admin:true) }

  subject(:result) do
    Character::New.({}, "current_user" => current_user)
  end

  context "policy violation" do

    let(:current_user){ User.new }

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
    expect( subject["model"] ).to be_a Character
    expect( subject["contract.default"] ).to be_a Character::Contract::Create
  end

end
