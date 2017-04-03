require 'rails_helper'

RSpec.describe Die, type: :model do

  describe "#roll" do

    context "no additional input" do

      specify do
        die = Die.new(20)
        20.times { expect( die.roll ).to be_between(1, 20) }
      end

      specify do
        die = Die.new(10)
        20.times { expect( die.roll ).to be_between(1, 10) }
      end

    end

    context "with modifier" do

      subject(:die) do
        Die.new(20)
      end

      before do
        allow_any_instance_of(Die).to receive(:die_roll).and_return 10
      end

      specify do
        expect( die.roll(5) ).to eq 15
      end

      specify do
        expect( die.roll(-5) ).to eq 5
      end

    end

  end

end
