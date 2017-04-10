module Navigation::Cell
  class Show < Trailblazer::Cell
    include Cell::Erb

    def role_cell
      model.admin? ? admin_cell : user_cell
    end

    private

    def admin_cell
      Navigation::Cell::Admin
    end

    def user_cell
      Navigation::Cell::User
    end
  end
end
