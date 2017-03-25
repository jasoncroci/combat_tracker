require 'rails_helper'

RSpec.describe Enemy::New, type: :concept do

  let!(:encounter) do
    Encounter.create!(name:"Encounter")
  end

  subject(:result) do
    Enemy::New.("encounter_id" =>  encounter.id)
  end

  specify do
    expect( subject.success? ).to be true
  end

  specify do
    expect( result["parent_model"].enemies ).to match_array [result["model"]]
  end

  specify do
    expect( result["model"] ).to be_a Enemy
    expect( result["contract.default"] ).to be_a Enemy::Contract::Create
  end

end
