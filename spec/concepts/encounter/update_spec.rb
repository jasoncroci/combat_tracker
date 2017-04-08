require 'rails_helper'

RSpec.describe Encounter::Update, type: :concept do

  let(:encounter) do
    Encounter.create!(name:"Test",challenge_rating:10,experience_points:10000)
  end

  let(:params) do
    {id: encounter.id, "encounter" => {name: "Encounter", challenge_rating: 5, experience_points: 9000}}
  end

  let(:current_user){ User.new(admin:true) }

  context "policy violation" do

    let(:current_user){ User.new }

    subject(:result) do
      Encounter::Update.(params)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Encounter::Update.({}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    subject(:result) do
      Encounter::Update.(params, "current_user" => current_user)
    end

    specify do
      expect( subject.success? ).to be true
    end

    specify do
      model = subject["model"]
      expect( model.name ).to eql "Encounter"
      expect( model.challenge_rating ).to eql 5
      expect( model.experience_points ).to eql 9000
    end

  end

end
