require 'rails_helper'

RSpec.describe Enemy::Update, type: :concept do

  let!(:encounter) do
    create(:encounter)
  end

  let!(:enemy) do
    create(:enemy, encounter: encounter)
  end

  let(:current_user){ build(:admin) }

  let(:params) do
    attributes_for(:enemy, name: "Bob", hit_points: 99, armor_class: 9, initiative_bonus: 2)
  end

  context "policy violation" do

    let(:current_user){ User.new }

    subject(:result) do
      Enemy::Update.(
        {id: enemy.id, "enemy" => params, "encounter_id" => encounter.id}
      )
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Enemy::Update.({}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    subject(:result) do
      Enemy::Update.(
        {id: enemy.id, "enemy" => params, "encounter_id" => encounter.id}, "current_user" => current_user
      )
    end

    specify do
      expect( subject.success? ).to be true
    end

    specify do
      model = subject["model"]
      expect( model.name ).to eql params[:name]
      expect( model.hit_points ).to eql params[:hit_points]
      expect( model.armor_class ).to eql params[:armor_class]
      expect( model.initiative_bonus ).to eql params[:initiative_bonus]
    end

  end

end
