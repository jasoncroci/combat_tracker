require 'rails_helper'

RSpec.describe Character::Update, type: :concept do

  let(:character) do
    Character.create!(name:"Test",hit_points:100,armor_class:10)
  end

  let(:params) do
    {id: character.id, "character" => {name: "Bob", hit_points: 99, armor_class: 9}}
  end

  let(:current_user){ User.new(admin:true) }

  context "policy violation" do

    let(:current_user){ User.new }

    subject(:result) do
      Character::Update.(params)
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
      Character::Update.(params, "current_user" => current_user)
    end

    specify do
      expect( subject.success? ).to be true
    end

    specify do
      model = subject["model"]
      expect( model.name ).to eql "Bob"
      expect( model.hit_points ).to eql 99
      expect( model.armor_class ).to eql 9
    end

  end

end
