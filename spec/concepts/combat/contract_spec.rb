require 'rails_helper'

RSpec.describe Combat::Contract::Create, type: :contract do

  let!(:encounter) do
    Encounter.create!(name: "Encounter1")
  end

  let!(:character1) do
    Character.create!(name:"Character1", hit_points: 200)
  end

  let!(:enemy1) do
    Enemy.create!(name:"Enemy1", hit_points: 100, encounter_id: encounter.id)
  end

  let!(:combat) do
    Combat.create
  end

  subject(:contract) do
    Combat::Contract::Create.new combat, encounter:encounter, enemies: [enemy1], characters: [character1]
  end

  describe "default values" do

    specify do
      expect( subject.current_round ).to eq 1
    end

    specify do
      expect( subject.enemies.first.current_hit_points ).to eq 100
    end

    specify do
      expect( subject.characters.first.current_hit_points ).to eq 200
    end

  end

  describe "populators" do

    let(:enemies_graph) do
      [{"name"=>"Troll 1asdf", "hit_points"=>110, "armor_class"=>13, "current_hit_points"=>110, "initiative"=>0}]
    end

    let(:characters_graph) do
      [{"name"=>"Gareth", "hit_points"=>99, "armor_class"=>20, "current_hit_points"=>99, "initiative"=>0}]
    end

    let(:encounter_graph) do
      {"name"=>"Encounter1", "challenge_rating"=>10, "experience_points"=>10000}
    end

    subject(:contract) do
      Combat::Contract::Create.new(Combat.new).deserialize(characters: characters_graph, enemies: enemies_graph, encounter: encounter_graph)
    end

    specify do
      expect( contract.to_nested_hash["encounter"] ).to eq encounter_graph
    end

    specify do
      expect( contract.to_nested_hash["enemies"] ).to eq enemies_graph
    end

    specify do
      expect( contract.to_nested_hash["characters"] ).to eq characters_graph
    end

  end

end
