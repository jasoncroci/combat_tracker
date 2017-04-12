require 'rails_helper'

RSpec.describe EncountersController, type: :controller do

  let(:admin) do
    create(:admin)
  end

  let!(:encounter) do
    create(:encounter, user: admin)
  end

  before(:each) do
    sign_in admin
  end

  describe "#index" do

    specify do
      get :index
      expect( response ).to render_template :index
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
      allow( Encounter::Create ).to receive(:call).and_return result
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
        expect( response ).to redirect_to encounters_path
      end

    end

  end

  describe "#edit" do

    specify do
      get :edit, params: {id: encounter.id}
      expect( response ).to render_template :edit
    end

  end

  describe "#update" do

    before do
      allow( Encounter::Update ).to receive(:call).and_return result
    end

    context "failure" do

      let(:result) do
        Trailblazer::Operation::Result.new(false, {})
      end

      specify do
        put :update, params: {id: encounter.id}
        expect( response ).to render_template :edit
      end

    end

    context "success" do

      let(:result) do
        Trailblazer::Operation::Result.new(true, {})
      end

      specify do
        put :update, params: {id: encounter.id}
        expect( response ).to redirect_to encounters_path
      end

    end

  end

end
