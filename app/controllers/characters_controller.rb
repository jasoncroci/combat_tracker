class CharactersController < ApplicationController

  def new
    run Character::New
    render :new, locals: { form: @form }
  end

  def create
    run Character::Create do |result|
      return redirect_to characters_path
    end

    render :new, locals: { form: @form }
  end

  def edit
    run Character::Edit

    render :edit, locals: { form: @form }
  end

  def update
    run Character::Update do |result|
      return redirect_to characters_path
    end

    render :edit, locals: { form: @form }
  end

  def index
    render :index, locals: { characters: Character.all }
  end

end
