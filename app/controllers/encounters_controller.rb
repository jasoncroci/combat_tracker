class EncountersController < ApplicationController

  def index
    render :index, locals: { encounters: Encounter.by_user(current_user) }
  end

  def new
    run Encounter::New

    render :new, locals: { form: @form }
  end

  def create
    run Encounter::Create do |result|
      return redirect_to encounters_path
    end

    render :new, locals: { form: @form }
  end

  def edit
    run Encounter::Edit

    render :edit, locals: { form: @form }
  end

  def update
    run Encounter::Update do |result|
      return redirect_to encounters_path
    end

    render :edit, locals: { form: @form }
  end

  def show
    run Encounter::Edit

    render :show, locals: { form: @form }
  end

end
