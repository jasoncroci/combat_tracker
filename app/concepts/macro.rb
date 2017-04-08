module Macro
  def self.AdminPolicy
    step = ->(input, options){ options["current_user"].try(:admin?) }

    [ step, name: "admin_policy" ] # :before, :replace, etc. work, too.
  end
end
