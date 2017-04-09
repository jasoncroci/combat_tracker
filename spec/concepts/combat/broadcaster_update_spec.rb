require 'rails_helper'

describe Combat::Broadcaster::Update, type: :model do
  include DeviseUser::Helpers

  let(:combat){ Combat.new }

  let(:contract) do
    Combat::Contract::Create.new combat, {
      encounter: Encounter.new,
      characters: [Character.new],
      enemies: [Enemy.new]
    }
  end

  subject(:broadcaster) do
    Combat::Broadcaster::Update.("current_user" => current_user, "contract.default" => contract)
  end

  context "admin user" do

    let(:current_user){ user(:admin) }

    specify do
      expect( subject ).to eq(
        current_user: { id: current_user.id, admin: true },
        message: contract.to_nested_hash
      )
    end

  end

  context "user" do

    let(:current_user){ user(:standard) }

    specify do
      expect( subject ).to eq(
        current_user: { id: current_user.id, admin: false },
        message: contract.to_nested_hash
      )
    end

  end


end
