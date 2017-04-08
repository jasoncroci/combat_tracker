require 'rails_helper'

RSpec.describe Encounter::Edit, type: :concept do

  let!(:encounter) do
    Encounter.create!(name:"Encounter1",challenge_rating:10,experience_points:10000)
  end

  let(:current_user){ User.new(admin:true) }

  context "policy violation" do

    let(:current_user){ User.new }

    subject(:result) do
      Encounter::Edit.({id: encounter.id})
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Encounter::Edit.({}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    subject(:result) do
      Encounter::Edit.({id: encounter.id}, "current_user" => current_user)
    end

    specify do
      expect( subject.success? ).to be true
    end

    specify do
      expect( subject["model"] ).to eq encounter
      expect( result["contract.default"] ).to be_a Encounter::Contract::Create
    end

  end

end
