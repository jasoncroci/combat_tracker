require 'rails_helper'

RSpec.describe Encounter::Update, type: :concept do

  let(:encounter) do
    create(:encounter, user: create(:admin))
  end

  let(:params) do
    attributes_for(:encounter, name: "UpdateEncounter", challenge_rating: 5, experience_points: 9000)
  end

  let(:current_user){ build(:admin) }

  context "policy violation" do

    let(:current_user){ build(:user) }

    subject(:result) do
      Encounter::Update.(
        {id: encounter.id, "encounter" => params}
      )
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Encounter::Update.(
        {}, "current_user" => current_user
      )
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    subject(:result) do
      Encounter::Update.(
        {id: encounter.id, "encounter" => params}, "current_user" => current_user
      )
    end

    specify do
      expect( result.success? ).to be true
    end

    specify do
      model = result["model"]
      expect( model.name ).to eql params[:name]
      expect( model.challenge_rating ).to eql params[:challenge_rating]
      expect( model.experience_points ).to eql params[:experience_points]
    end

  end

end
