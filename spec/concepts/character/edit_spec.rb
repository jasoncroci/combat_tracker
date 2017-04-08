require 'rails_helper'

RSpec.describe Character::Edit, type: :concept do

  let!(:character) do
    Character.create!(name:"Test",hit_points:100,armor_class:10)
  end

  let(:current_user){ User.new(admin:true) }

  context "policy violation" do

    let(:current_user){ User.new }

    subject(:result) do
      Character::Edit.(id: character.id)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Character::Edit.({}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    subject(:result) do
      Character::Edit.({id: character.id}, "current_user" => current_user)
    end

    specify do
      expect( subject.success? ).to be true
    end

    specify do
      expect( subject["model"] ).to eq character
      expect( result["contract.default"] ).to be_a Character::Contract::Create
    end

  end

end
