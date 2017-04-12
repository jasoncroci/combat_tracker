require 'rails_helper'

RSpec.describe Enemy::Create, type: :concept do

  let(:encounter) do
    create(:encounter)
  end

  let(:current_user){ build(:admin) }

  let(:params) do
    attributes_for(:enemy)
  end

  context "policy violation" do

    subject(:result) do
      Enemy::Create.(
        {"encounter_id" => encounter.id, "enemy" => params}
      )
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Enemy::Create.(
        {"encounter_id" => encounter.id, "enemy" => {}}, "current_user" => current_user
      )
    end

    specify do
      expect( result.success? ).to be false
      expect( result["contract.default"].errors.keys ).to match_array [:name]
    end

  end

  context "success" do

    subject(:result) do
      Enemy::Create.(
        {"encounter_id" => encounter.id, "enemy" => params}, "current_user" => current_user
      )
    end

    specify do
      expect( result.success? ).to be true
    end

    specify do
      model = result["model"]
      expect( model.persisted? ).to be true
      expect( model.encounter ).to eq encounter
      expect( model.name ).to eq params[:name]
      expect( model.armor_class ).to eq params[:armor_class]
      expect( model.initiative_bonus ).to eq params[:initiative_bonus]
    end

  end

end
