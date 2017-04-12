require 'rails_helper'

RSpec.describe Enemy, type: :model do

  let(:encounter) do
    create(:encounter, user: create(:admin))
  end

  let!(:enemy) do
    create(:enemy, encounter: encounter)
  end

  describe "#encounter" do

    specify do
      expect( enemy.encounter ).to eq encounter
    end

  end

end
