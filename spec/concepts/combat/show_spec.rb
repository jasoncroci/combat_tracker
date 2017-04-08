require 'rails_helper'

RSpec.describe Combat::Show, type: :concept do

  let!(:combat) do
    Combat.create!(data:{"encounter" => {"name" => "Encounter1"}})
  end

  let(:current_user){ User.new }

  subject(:result) do
    Combat::Show.({id: combat.id}, "current_user" => current_user)
  end

  context "invalid params" do

    specify do
      result = Combat::Show.({}, "current_user" => current_user)
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
    expect( result["contract.default"].encounter.name ).to eq "Encounter1"
  end

end
