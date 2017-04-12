require 'rails_helper'

RSpec.describe CharactersController, type: :controller do

  let!(:character) do
    create(:character)
  end

  before(:each) do
    sign_in user
  end

  describe "#index" do

    specify do
      get :index
      expect(response.status).to eq(200)
    end

  end

  describe "#new" do

    specify do
      get :new
      expect( response ).to render_template :new
    end

  end

  describe "#create" do

    before do
      allow( Character::Create ).to receive(:call).and_return result
    end

    context "failure" do

      let(:result) do
        Trailblazer::Operation::Result.new(false, {})
      end

      specify do
        post :create
        expect( response ).to render_template :new
      end

    end

    context "success" do

      let(:result) do
        Trailblazer::Operation::Result.new(true, {})
      end

      specify do
        post :create
        expect( response ).to redirect_to characters_path
      end

    end

  end

  describe "#edit" do

    specify do
      get :edit, params: {id: character.id}
      expect( response ).to render_template :edit
    end

  end

  describe "#update" do

    before do
      allow( Character::Update ).to receive(:call).and_return result
    end

    context "failure" do

      let(:result) do
        Trailblazer::Operation::Result.new(false, {})
      end

      specify do
        put :update, params: {id: character.id}
        expect( response.status ).to eq 422
      end

    end

    context "success" do

      let(:result) do
        Trailblazer::Operation::Result.new(true, {})
      end

      specify do
        put :update, params: {id: character.id}
        expect( response.status ).to eq 202
      end

    end

  end

end
