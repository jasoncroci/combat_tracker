class EnemiesController < ApplicationController

  def new
    run Enemy::New
    render :new, locals: { encounter: @_result["parent_model"], form: @form }
  end

  def create
    run Enemy::Create do |result|
      return redirect_to encounter_enemies_path
    end

    render :new, locals: { form: @form }
  end

  def edit
    run Enemy::Edit

    render :edit, locals: { encounter: @_result["parent_model"], form: @form }
  end

  def update
    run Enemy::Update do |result|
      return render json: @form, status: :accepted
    end
    render json: @form, status: :unprocessable_entity
  end

  def index
    run Enemy::New do |result|
      return render :index, locals: { encounter: result["parent_model"], enemies: result["parent_model"].enemies.all }
    end
  end

end
