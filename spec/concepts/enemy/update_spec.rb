require 'rails_helper'

RSpec.describe Enemy::Update, type: :concept do

  let!(:encounter) do
    Encounter.create!(name:"Encounter")
  end

  let!(:enemy) do
    Enemy.create!(name:"Test",hit_points:100,armor_class:10, encounter: encounter)
  end

  context "invalid input" do

    subject(:result) do
      Enemy::Update.()
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    subject(:result) do
      Enemy::Update.(id: enemy.id, "enemy" => {name: "Bob", hit_points: 99, armor_class: 9}, "encounter_id" => encounter.id)
    end

    specify do
      expect( subject.success? ).to be true
    end

    specify do
      model = subject["model"]
      expect( model.name ).to eql "Bob"
      expect( model.hit_points ).to eql 99
      expect( model.armor_class ).to eql 9
    end

  end

end
