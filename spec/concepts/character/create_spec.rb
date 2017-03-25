require 'rails_helper'

RSpec.describe Character::Create, type: :concept do

  context "invalid input" do

    subject(:result) do
      Character::Create.("character" => {})
    end

    specify do
      expect( result.success? ).to be false
      expect( result["contract.default"].errors.keys ).to match_array [:name]
    end

  end

  context "success" do

    subject(:result) do
      Character::Create.("character" => {name: "Bob", hit_points: 100, armor_class: 20})
    end

    specify do
      expect( subject.success? ).to be true
    end

    specify do
      expect( subject["model"] ).to be_a Character
      expect( subject["model"].persisted? ).to be true
    end

  end

end
