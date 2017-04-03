require 'rails_helper'

RSpec.describe Enemy::Create, type: :concept do

  let!(:encounter) do
    Encounter.create!(name:"Encounter")
  end

  context "invalid input" do

    subject(:result) do
      Enemy::Create.("encounter_id" =>  encounter.id, "enemy" => {})
    end

    specify do
      expect( result.success? ).to be false
      expect( result["contract.default"].errors.keys ).to match_array [:name]
    end

  end

  context "success" do

    subject(:result) do
      Enemy::Create.("encounter_id" =>  encounter.id, "enemy" => {name: "Bob", hit_points: 100, armor_class: 20, initiative_bonus: 0})
    end

    specify do
      expect( subject.success? ).to be true
    end

    specify do
      expect( subject["model"] ).to be_a Enemy
      expect( subject["model"].persisted? ).to be true
      expect( subject["model"].encounter ).to eq encounter
    end

  end

end
