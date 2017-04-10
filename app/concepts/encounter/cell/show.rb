module Encounter::Cell
  class Show < Trailblazer::Cell
    include Cell::Erb
    include BootstrapForm::Helper
    include ActionView::Helpers::NumberHelper
    property :name
    property :challenge_rating
    property :experience_points
    property :enemies
  end
end
