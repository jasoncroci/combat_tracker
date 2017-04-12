require 'rails_helper'

RSpec.describe Encounter, type: :model do

  let(:admin1) do
    create(:admin)
  end

  let(:admin2) do
    create(:admin, email: "admin2@admin.com")
  end

  let(:encounter1) do
    create(:encounter, user: admin1)
  end

  let(:encounter2) do
    create(:encounter, user: admin2)
  end

  let(:enemy1) do
    create(:enemy, encounter: encounter1)
  end

  let(:enemy2) do
    create(:enemy, encounter: encounter1)
  end

  describe "#enemies" do

    specify do
      expect( encounter1.enemies ).to match_array [enemy1, enemy2]
    end

  end

  describe "by_user scope" do

    specify do
      expect( Encounter.by_user(admin1) ).to match_array [encounter1]
    end

    specify do
      expect( Encounter.by_user(admin2) ).to match_array [encounter2]
    end

  end

end
