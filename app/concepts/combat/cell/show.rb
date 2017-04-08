module Combat::Cell
  class Show < Trailblazer::Cell
    include ::Cell::Builder

    builds do |model, options|
      if options[:current_user].admin?
        Combat::Cell::Admin::Show
      else
        Combat::Cell::User::Show
      end
    end
  end
end
