module Navigation::Cell
  class User < Trailblazer::Cell
    include Cell::Erb
    property :email
  end
end
