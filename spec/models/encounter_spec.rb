require 'rails_helper'

RSpec.describe Encounter, type: :model do

  let!(:encounter) do
    Encounter.create!(name: "Encounter1",user:user)
  end

  let!(:enemy1) do
    Enemy.create!(name:"Enemy1", encounter_id: encounter.id)
  end

  let!(:enemy2) do
    Enemy.create!(name:"Enemy2", encounter_id: encounter.id)
  end

  describe "#enemies" do

    specify do
      expect( encounter.enemies ).to match_array [enemy1, enemy2]
    end

  end

end
