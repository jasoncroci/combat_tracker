require 'rails_helper'

RSpec.describe Combat::Create, type: :concept do

  let(:encounter) do
    create(:encounter)
  end

  let(:enemy1) do
    create(:enemy)
  end

  let!(:character1) do
    create(:character)
  end

  let(:current_user){ build(:admin) }

  subject(:result) do
    Combat::Create.(
      {"encounter_id" => encounter.id}, "current_user" => current_user
    )
  end

  context "policy violation" do

    let(:current_user){ build(:user) }

    subject(:result) do
      Combat::Create.(
        {"encounter_id" => encounter.id}
      )
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid params" do

    specify do
      result = Combat::Create.({}, "current_user" => current_user)
      expect( result.success? ).to be false
    end

  end

  specify do
    expect( result.success? ).to be true
  end

  specify do
    expect( result["encounter"] ).to eq encounter
  end

  specify do
    expect( result["enemies"] ).to eq encounter.enemies
    expect( result["characters"] ).to eq [character1]
    expect( result["contract.default"] ).to be_a Combat::Contract::Create
  end

  specify do
    model = result["model"]
    expect( model ).to be_a Combat
    expect( model.persisted? ).to be true
    expect( model.data ).to_not be_empty
  end

end
