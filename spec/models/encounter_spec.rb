require 'rails_helper'

RSpec.describe Encounter, type: :model do

  let!(:encounter) do
    Encounter.create!(name: "Encounter1")
  end

  let!(:enemy1) do
    Enemy.create!(name:"Enemy1", encounter_id: encounter.id)
  end

  let!(:enemy2) do
    Enemy.create!(name:"Enemy2", encounter_id: encounter.id)
  end

  let!(:character1) do
    Character.create!(name:"Player1")
  end

  let!(:character2) do
    Character.create!(name:"Character2")
  end

  describe "#enemies" do

    specify do
      expect( encounter.enemies ).to match_array [enemy1, enemy2]
    end

  end

  describe "#characters" do

    specify do
      expect( encounter.characters ).to match_array [character1, character2]
    end

  end

end
