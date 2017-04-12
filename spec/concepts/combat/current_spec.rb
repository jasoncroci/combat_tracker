require 'rails_helper'

RSpec.describe Combat::Current, type: :concept do

  let!(:encounter) do
    create(:encounter)
  end

  let!(:combat) do
    create(:combat, encounter: encounter)
  end

  subject(:result) do
    Combat::Current.()
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
