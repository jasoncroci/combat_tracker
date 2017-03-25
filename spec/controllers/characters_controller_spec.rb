require 'rails_helper'

RSpec.describe CharactersController, type: :controller do

  describe "#new" do

    specify do
      get :new
      expect( response ).to render_template :new
    end

  end

end
