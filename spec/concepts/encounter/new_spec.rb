require 'rails_helper'

RSpec.describe Encounter::New, type: :concept do

  let(:current_user){ build(:admin) }

  subject(:result) do
    Encounter::New.(
      {}, "current_user" => current_user
    )
  end

  context "policy violation" do

    let(:current_user){ build(:user) }

    specify do
      expect( result.success? ).to be false
    end

  end

  specify do
    expect( subject.success? ).to be true
  end

  specify do
    expect( subject["model"] ).to be_a Encounter
    expect( subject["contract.default"] ).to be_a Encounter::Contract::Create
  end

end
