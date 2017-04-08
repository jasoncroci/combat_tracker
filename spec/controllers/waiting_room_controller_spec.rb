require 'rails_helper'

RSpec.describe WaitingRoomController, type: :controller do

  describe "#index" do

    context "not logged in" do

      specify do
        get :index
        expect( response ).to redirect_to new_user_session_path
      end

    end

    context "logged in as user" do

      before(:each) do
        sign_in user(:user)
      end

      specify do
        get :index
        expect( response ).to render_template :index
      end

    end

    context "logged in as admin" do

      before(:each) do
        sign_in user(:admin)
      end

      specify do
        get :index
        expect( response ).to redirect_to encounters_path
      end

    end

  end

end
