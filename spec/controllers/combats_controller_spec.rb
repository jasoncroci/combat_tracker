require 'rails_helper'

RSpec.describe CombatsController, type: :controller do

  let!(:combat) do
    Combat.create!(data:{encounter:{name:"Test"}})
  end

  before(:each) do
    sign_in user
  end

  describe "#create" do

    before do
      allow( Combat::Create ).to receive(:call).and_return result
    end

    context "failure" do

      let(:result) do
        Trailblazer::Operation::Result.new(false, {})
      end

      specify do
        post :create, params: { encounter_id: 1 }
        expect( response ).to redirect_to encounter_path(1)
      end

    end

    context "success" do

      let(:result) do
        Trailblazer::Operation::Result.new(true, { "model" => double(id:1) })
      end

      specify do
        post :create, params: { encounter_id: 1 }
        expect( response ).to redirect_to combat_path(1)
      end

    end

  end

  describe "#update" do

    before do
      allow( Combat::Update ).to receive(:call).and_return result
    end

    context "failure" do

      let(:result) do
        Trailblazer::Operation::Result.new(false, {})
      end

      specify do
        put :update, params: {id: combat.id}
        expect( response.status ).to eq 422
      end

    end

    context "success" do

      let(:result) do
        Trailblazer::Operation::Result.new(true, {})
      end

      specify do
        put :update, params: {id: combat.id}
        expect( response.status ).to eq 202
      end

    end

  end


  describe "#show" do

    specify do
      get :show, params: { id: combat.id }
      expect(response.status).to eq(200)
    end

  end

  describe "#current_combat" do

    context "failure" do

      before do
        allow( Combat::Current ).to receive(:call).and_return result
      end

      let(:result) do
        Trailblazer::Operation::Result.new(false, {})
      end

      specify do
        get :current_combat
        expect( response ).to redirect_to root_path
      end

    end

    context "success" do

      specify do
        get :current_combat
        expect(response.status).to eq(200)
      end

    end

  end

end
