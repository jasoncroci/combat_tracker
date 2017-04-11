require 'rails_helper'

RSpec.describe Combat::Delete, type: :concept do

  let(:encounter) do
    Encounter.create!(name:"Test",challenge_rating:10,experience_points:10000,user:user)
  end

  let!(:combat) do
    Combat.create!(data:{}, user: user, encounter: encounter)
  end

  let(:current_user){ User.new(admin:true) }

  context "policy violation" do

    subject(:result) do
      Combat::Delete.({id:combat.id})
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid params" do

    subject(:result) do
      Combat::Delete.({}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  subject(:result) do
    Combat::Delete.({id:combat.id}, "current_user" => current_user)
  end

  specify do
    expect( result.success? ).to be true
  end

  specify do
    expect( Combat.find_by(id: result["model"].id) ).to be nil
  end

end
