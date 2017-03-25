require 'rails_helper'

RSpec.describe Encounter::New, type: :concept do

  subject(:result) do
    Encounter::New.()
  end

  specify do
    expect( subject.success? ).to be true
  end

  specify do
    expect( subject["model"] ).to be_a Encounter
    expect( subject["contract.default"] ).to be_a Encounter::Contract::Create
  end

end
