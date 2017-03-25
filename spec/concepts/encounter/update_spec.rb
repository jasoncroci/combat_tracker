require 'rails_helper'

RSpec.describe Encounter::Update, type: :concept do

  let(:encounter) do
    Encounter.create!(name:"Test",challenge_rating:10,experience_points:10000)
  end

  context "invalid input" do

    subject(:result) do
      Encounter::Update.()
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    subject(:result) do
      Encounter::Update.(id: encounter.id, "encounter" => {name: "Encounter", challenge_rating: 5, experience_points: 9000})
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
