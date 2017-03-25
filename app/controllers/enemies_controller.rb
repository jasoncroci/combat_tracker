class EnemiesController < ApplicationController

  def new
    run Enemy::New
    render :new, locals: { form: @form }
  end

  def create
    run Enemy::Create do |result|
      return redirect_to enemies_path
    end

    render :new, locals: { form: @form }
  end

  def edit
    run Enemy::Edit

    render :edit, locals: { form: @form }
  end

  def update
    run Enemy::Update do |result|
      return redirect_to enemies_path
    end

    render :edit, locals: { form: @form }
  end

  def index
    render :index, locals: { enemies: Enemy.all }
  end

end
