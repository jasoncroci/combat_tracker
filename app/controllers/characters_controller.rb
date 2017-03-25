class CharactersController < ApplicationController

  def new
    run Character::New
    render :new, locals: { form: @form }
  end

end
