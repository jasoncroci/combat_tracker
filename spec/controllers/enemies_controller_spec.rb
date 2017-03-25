require 'rails_helper'

RSpec.describe EnemiesController, type: :controller do

  let!(:enemy) do
    Enemy.create!(name:"Test",hit_points:100,armor_class:10)
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
      allow( Enemy::Create ).to receive(:call).and_return result
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
        expect( response ).to redirect_to enemies_path
      end

    end

  end

  describe "#edit" do

    specify do
      get :edit, params: {id: enemy.id}
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
        put :update, params: {id: enemy.id}
        expect( response ).to render_template :edit
      end

    end

    context "success" do

      let(:result) do
        Trailblazer::Operation::Result.new(true, {})
      end

      specify do
        put :update, params: {id: enemy.id}
        expect( response ).to redirect_to enemies_path
      end

    end

  end

end
