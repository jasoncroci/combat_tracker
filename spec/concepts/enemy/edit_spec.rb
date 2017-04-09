require 'rails_helper'

RSpec.describe Enemy::Edit, type: :concept do

  let!(:encounter) do
    Encounter.create!(name:"Encounter",user:user)
  end

  let!(:enemy) do
    Enemy.create!(name:"Test", hit_points:100, armor_class:10, encounter: encounter)
  end

  let(:current_user){ User.new(admin:true) }

  let(:params) do
    {id: enemy.id, "encounter_id" => encounter.id}
  end

  context "policy violation" do

    let(:current_user){ User.new }

    subject(:result) do
      Enemy::Edit.(params)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Enemy::Edit.({}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    subject(:result) do
      Enemy::Edit.(params, "current_user" => current_user)
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
