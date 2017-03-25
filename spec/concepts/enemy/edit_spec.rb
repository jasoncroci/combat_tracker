require 'rails_helper'

RSpec.describe Enemy::Edit, type: :concept do

  context "invalid input" do

    subject(:result) do
      Enemy::Edit.()
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    let!(:enemy) do
      Enemy.create!(name:"Test",hit_points:100,armor_class:10)
    end

    subject(:result) do
      Enemy::Edit.(id: enemy.id)
    end

    specify do
      expect( subject.success? ).to be true
    end

    specify do
      expect( subject["model"] ).to eq enemy
      expect( result["contract.default"] ).to be_a Enemy::Contract::Create
    end

  end

end
