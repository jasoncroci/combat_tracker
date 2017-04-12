require 'rails_helper'

RSpec.describe Combat::Show, type: :concept do

  let(:encounter) do
    create(:encounter)
  end

  let!(:combat) do
    create(:combat, encounter: encounter)
  end

  let(:current_user){ build(:user) }

  subject(:result) do
    Combat::Show.(
      {id: combat.id}, "current_user" => current_user
    )
  end

  context "invalid params" do

    subject(:result) do
      Combat::Show.({}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  specify do
    expect( result.success? ).to be true
  end

  specify do
    expect( result["model"] ).to eq combat
  end

  specify do
    expect( result["contract.default"] ).to be_a Combat::Contract::Create
  end

  specify do
    expect( result["contract.default"].encounter.name ).to eq encounter.name
  end

end
