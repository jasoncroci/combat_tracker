require 'rails_helper'

RSpec.describe Enemy, type: :model do

  let!(:encounter) do
    Encounter.create!(name: "Encounter1")
  end

  let!(:enemy) do
    Enemy.create!(name:"Enemy1", encounter_id: encounter.id)
  end

  describe "#encounter" do

    specify do
      expect( enemy.encounter ).to eq encounter
    end

  end

end
