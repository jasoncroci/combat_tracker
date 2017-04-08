class CombatsController < ApplicationController
  include ::Cell::Erb

  def create
    run Combat::Create do |result|
      return redirect_to combat_path(result["model"].id)
    end

    redirect_to encounter_path(params["encounter_id"])
  end

  def update
    run Combat::Update do |result|
      return render json: @form, status: :accepted
    end
    render json: @form, status: :unprocessable_entity
  end

  def show
    run Combat::Show

    render cell(Combat::Cell::Show, @form, current_user: current_user)
  end
end
