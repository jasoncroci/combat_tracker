require 'rails_helper'

RSpec.describe Encounter::Create, type: :concept do

  let(:params) do
    attributes_for(:encounter)
  end

  let(:current_user){ User.new(admin:true) }

  context "policy violation" do

    let(:current_user){ User.new }

    subject(:result) do
      Encounter::Create.(
        {"encounter" => params}
      )
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Encounter::Create.(
        {"encounter" => {}}, "current_user" => current_user
      )
    end

    specify do
      expect( result.success? ).to be false
      expect( result["contract.default"].errors.keys ).to match_array [:name]
    end

  end

  context "success" do

    subject(:result) do
      Encounter::Create.(
        {"encounter" => params}, "current_user" => current_user
      )
    end

    specify do
      expect( result.success? ).to be true
    end

    specify do
      model = result["model"]
      expect( model.persisted? ).to be true
      expect( model.name ).to eq params[:name]
      expect( model.challenge_rating ).to eq params[:challenge_rating]
      expect( model.experience_points ).to eq params[:experience_points]
    end

  end

end
