require 'rails_helper'

RSpec.describe EnemiesController, type: :controller do

  let(:admin) do
    create(:admin)
  end

  let(:encounter) do
    create(:encounter, user: admin)
  end

  let(:enemy) do
    create(:enemy, encounter: encounter)
  end

  before(:each) do
    sign_in admin
  end

  describe "#index" do

    specify do
      get :index, params: { encounter_id: encounter }
      expect( response ).to render_template :index
    end

  end

  describe "#new" do

    specify do
      get :new, params: { encounter_id: encounter }
      expect( response ).to render_template :new
    end

  end

  describe "#create" do

    before do
      allow( Enemy::Create ).to receive(:call).and_return result
    end

    context "failure" do

      let(:result) do
        Trailblazer::Operation::Result.new(false, {})
      end

      specify do
        post :create, params: { encounter_id: encounter }
        expect( response ).to render_template :new
      end

    end

    context "success" do

      let(:result) do
        Trailblazer::Operation::Result.new(true, {})
      end

      specify do
        post :create, params: { encounter_id: encounter }
        expect( response ).to redirect_to encounter_enemies_path
      end

    end

  end

  describe "#edit" do

    specify do
      get :edit, params: {encounter_id: encounter.id, id: enemy.id}
      expect( response ).to render_template :edit
    end

  end

  describe "#update" do

    before do
      allow( Enemy::Update ).to receive(:call).and_return result
    end

    context "failure" do

      let(:result) do
        Trailblazer::Operation::Result.new(false, {})
      end

      specify do
        put :update, params: {encounter_id: encounter.id, id: enemy.id}
        expect( response.status ).to eq 422
      end

    end

    context "success" do

      let(:result) do
        Trailblazer::Operation::Result.new(true, {})
      end

      specify do
        put :update, params: {encounter_id: encounter.id, id: enemy.id}
        expect( response.status ).to eq 202
      end

    end

  end

end
