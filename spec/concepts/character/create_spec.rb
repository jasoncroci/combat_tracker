require 'rails_helper'

RSpec.describe Character::Create, type: :concept do

  let(:params) do
    attributes_for(:character)
  end

  let(:current_user){ build(:admin) }

  context "policy violation" do

    let(:current_user){ build(:user) }

    subject(:result) do
      Character::Create.(params)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Character::Create.({"character" => {}}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
      expect( result["contract.default"].errors.keys ).to match_array [:name]
    end

  end

  context "success" do

    subject(:result) do
      Character::Create.(
        {"character" => params}, "current_user" => current_user
      )
    end

    specify do
      expect( result.success? ).to be true
    end

    specify do
      model = result["model"]
      expect( model.persisted? ).to be true
      expect( model.name ).to eq params[:name]
      expect( model.hit_points ).to eq params[:hit_points]
      expect( model.armor_class ).to eq params[:armor_class]
    end

  end

end
