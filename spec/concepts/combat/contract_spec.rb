require 'rails_helper'

RSpec.describe Combat::Contract::Create, type: :concept do

  let(:encounter) do
    create(:encounter)
  end

  let(:character1) do
    create(:character)
  end

  let!(:enemy1) do
    create(:enemy, encounter: encounter)
  end

  let(:combat) do
    Combat.new
  end

  subject(:contract) do
    Combat::Contract::Create.new combat, {
      encounter:encounter,
      enemies: [enemy1],
      characters: [character1]
    }
  end

  describe "default values" do

    specify do
      expect( contract.current_round ).to eq 1
      expect( contract.enemies.first.current_hit_points ).to eq 200
      expect( contract.characters.first.current_hit_points ).to eq 100
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
      Combat::Contract::Create.new(Combat.new).deserialize(
        characters: characters_graph, enemies: enemies_graph, encounter: encounter_graph
      )
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

  describe "identity" do

    specify do
      expect( contract.characters.first.identity ).to eq "character_#{character1.id}"
    end

    specify do
      expect( contract.enemies.first.identity ).to eq "enemy_#{enemy1.id}"
    end

  end

  describe "start_combat!" do

    let!(:enemy2) do
      create(:enemy, encounter: encounter, initiative_bonus: 5)
    end

    subject(:contract) do
      Combat::Contract::Create.new combat, {
        enemies: [enemy1,enemy2]
      }
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
      create(:character)
    end

    let!(:enemy2) do
      create(:enemy, encounter: encounter)
    end

    before do
      contract.enemies << enemy2
      contract.characters << character2
      contract.enemies.first.initiative = "5"
      contract.enemies.last.initiative = "15"
      contract.characters.first.initiative = "10"
      contract.characters.last.initiative = "20"
    end

    context "all combatants active" do

      specify do
        expect( contract.combatants ).to eq [contract.characters.last, contract.enemies.last, contract.characters.first, contract.enemies.first]
      end

    end

    context "enemy combatants defeated" do

      before do
        contract.enemies.first.current_hit_points = 0
        contract.enemies.last.current_hit_points = -10
      end

      specify do
        expect( contract.combatants ).to eq [contract.characters.last, contract.characters.first]
      end

    end

    context "characters unconscious" do

      before do
        contract.characters.first.current_hit_points = 0
        contract.characters.last.current_hit_points = -10
      end

      specify do
        expect( contract.combatants ).to eq [contract.characters.last, contract.enemies.last, contract.characters.first, contract.enemies.first]
      end

    end

  end

end
