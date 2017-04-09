module Combat::Cell::Admin
  class Show < Combat::Cell::User::Show
    include Cell::Erb
    property :encounter
  end
end
