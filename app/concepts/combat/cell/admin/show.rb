module Combat::Cell::Admin
  class Show < Combat::Cell::User::Show
    include Cell::Erb
    include ActionView::Helpers::JavaScriptHelper
    property :encounter

    def show
      render + render("admin/javascript")
    end

    def admin?
      true
    end
  end
end
