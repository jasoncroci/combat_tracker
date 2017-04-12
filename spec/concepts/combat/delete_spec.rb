require 'rails_helper'

RSpec.describe Combat::Delete, type: :concept do

  let(:encounter) do
    create(:encounter)
  end

  let!(:combat) do
    create(:combat, encounter: encounter)
  end

  let(:current_user){ build(:admin) }

  context "policy violation" do

    subject(:result) do
      Combat::Delete.(
        {id:combat.id}
      )
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
    Combat::Delete.(
      {id:combat.id}, "current_user" => current_user
    )
  end

  specify do
    expect( result.success? ).to be true
  end

  specify do
    expect( Combat.find_by(id: result["model"].id) ).to be nil
  end

end
