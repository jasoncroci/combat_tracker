require 'rails_helper'

RSpec.describe Combat::Update, type: :concept do

  let(:encounter) do
    Encounter.create!(name:"Test",challenge_rating:10,experience_points:10000,user:user)
  end

  let!(:combat) do
    Combat.create!(data:{}, user: user, encounter: encounter)
  end

  let(:data) do
    {"current_round"=>1, "current_turn" => nil, "encounter"=>nil, "enemies"=>[], "characters"=>[]}
  end

  let(:current_user){ User.new(admin:true) }

  subject(:result) do
    Combat::Update.({id: combat.id, "combat" => data}, "current_user" => current_user)
  end

  context "policy violation" do

    let(:current_user){ User.new }

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Combat::Update.({}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    specify do
      expect( result.success? ).to be true
    end

    specify do
      expect( result["model"].data ).to eql data
    end

  end

end
