require 'rails_helper'

RSpec.describe Character::Update, type: :concept do

  let(:character) do
    create(:character)
  end

  let(:params) do
    attributes_for(:character, name: "EditName", hit_points: 1, armor_class: 10)
  end

  let(:current_user){ build(:admin) }

  context "policy violation" do

    let(:current_user){ User.new }

    subject(:result) do
      Character::Update.(
        {id: character.id, "character" => params}
      )
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "invalid input" do

    subject(:result) do
      Character::Update.({}, "current_user" => current_user)
    end

    specify do
      expect( result.success? ).to be false
    end

  end

  context "success" do

    subject(:result) do
      Character::Update.(
        {id: character.id, "character" => params}, "current_user" => current_user
      )
    end

    specify do
      expect( result.success? ).to be true
    end

    specify do
      model = result["model"]
      expect( model.name ).to eql "EditName"
      expect( model.hit_points ).to eql 1
      expect( model.armor_class ).to eql 10
    end

  end

end
