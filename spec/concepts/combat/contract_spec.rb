require 'rails_helper'

RSpec.describe Combat::Contract::Create, type: :contract do

  let!(:encounter) do
    Encounter.create!(name: "Encounter1")
  end

  let!(:character1) do
    Character.create!(name:"Character1", hit_points: 200)
  end

  let!(:enemy1) do
    Enemy.create!(name:"Enemy1", hit_points: 100, encounter_id: encounter.id, initiative_bonus: 0)
  end

  let(:combat) do
    Combat.new
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
      [{"id" => nil, "name"=>"Troll 1asdf", "hit_points"=>110, "armor_class"=>13, "current_hit_points"=>110, "initiative"=>0, "initiative_bonus" =>0}]
    end

    let(:characters_graph) do
      [{"id" => nil, "name"=>"Gareth", "hit_points"=>99, "armor_class"=>20, "current_hit_points"=>99, "initiative"=>0}]
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

  describe "start_combat!" do

    let!(:enemy2) do
      Enemy.create!(name:"Enemy2", hit_points: 50, encounter_id: encounter.id, initiative_bonus: 5)
    end

    subject(:contract) do
      Combat::Contract::Create.new combat, enemies: [enemy1,enemy2]
    end

    before do
      allow( D20 ).to receive(:roll).with(0).and_return 10
      allow( D20 ).to receive(:roll).with(5).and_return 15
    end

    specify do
      contract.start_combat!
      expect( contract.enemies.first.initiative ).to eq 10
      expect( contract.enemies.last.initiative ).to eq 15
    end

  end

  describe "combatants" do

    let!(:character2) do
      Character.create!(name:"Character2")
    end

    let!(:enemy2) do
      Enemy.create!(name:"Enemy2", encounter_id: encounter.id)
    end

    before do
      contract.enemies << enemy2
      contract.characters << character2
      contract.enemies.first.initiative = "5"
      contract.enemies.last.initiative = "15"
      contract.characters.first.initiative = "10"
      contract.characters.last.initiative = "20"
    end

    specify do
      expect( contract.combatants ).to eq [contract.characters.last, contract.enemies.last, contract.characters.first, contract.enemies.first]
    end

  end

end
