require 'rails_helper'

RSpec.describe Combat::Update, type: :concept do

  let!(:combat) do
    Combat.create!(data:{})
  end

  context "invalid input" do

    subject(:result) do
      Combat::Update.()
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    let(:data) do
      {"current_round"=>1, "current_turn" => nil, "encounter"=>nil, "enemies"=>[], "characters"=>[]}
    end

    subject(:result) do
      Combat::Update.(id: combat.id, "combat" => data)
    end

    specify do
      expect( result.success? ).to be true
    end

    specify do
      expect( result["model"].data ).to eql data
    end

  end

end
