require 'rails_helper'

RSpec.describe Combat::Create, type: :concept do

  let!(:encounter) do
    Encounter.create!(name:"Encounter", user: user)
  end

  let!(:enemy1) do
    Enemy.create!(name:"Enemy1", encounter: encounter)
  end

  let!(:character1) do
    Character.create!(name:"Character")
  end

  let(:current_user){ User.new(admin:true) }

  subject(:result) do
    Combat::Create.({"encounter_id" => encounter.id}, "current_user" => current_user)
  end

  context "policy violation" do

    let(:current_user){ User.new }

    subject(:result) do
      Combat::Create.({"encounter_id" => encounter.id})
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
    expect( result["model"] ).to be_a Combat
  end

  specify do
    expect( result["enemies"] ).to eq encounter.enemies
  end

  specify do
    expect( result["characters"] ).to eq [character1]
  end

  specify do
    expect( result["contract.default"] ).to be_a Combat::Contract::Create
  end

  specify do
    expect( result["model"].persisted? ).to be true
  end

end
