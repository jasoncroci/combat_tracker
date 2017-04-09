module Combat::Broadcaster
  class Update
    def self.call(options)
      {
        current_user: { id: options["current_user"].id, admin: options["current_user"].admin? },
        message: options["contract.default"].to_nested_hash
      }
    end
  end
end
