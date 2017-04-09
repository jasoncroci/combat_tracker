require 'rails_helper'

RSpec.describe Encounter, type: :model do

  let!(:encounter1) do
    Encounter.create!(name: "Encounter1",user:user)
  end

  let!(:encounter2) do
    Encounter.create!(name: "Encounter2",user:user(:standard))
  end

  let!(:enemy1) do
    Enemy.create!(name:"Enemy1", encounter_id: encounter1.id)
  end

  let!(:enemy2) do
    Enemy.create!(name:"Enemy2", encounter_id: encounter1.id)
  end

  describe "#enemies" do

    specify do
      expect( encounter1.enemies ).to match_array [enemy1, enemy2]
    end

  end

  describe "by_user scope" do

    specify do
      expect( Encounter.by_user(user) ).to match_array [encounter1]
    end

    specify do
      expect( Encounter.by_user(user(:standard)) ).to match_array [encounter2]
    end

  end

end
