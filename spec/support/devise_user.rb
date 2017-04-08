module DeviseUser
  module Helpers
    def self.User
      User.create_with(password: "Password").find_or_create_by!(email: "user@user.com")
    end

    def self.Admin
      User.create_with(password: "Password",admin:true).find_or_create_by!(email: "admin@admin.com")
    end

    def user(role=:admin)
      role.eql?(:admin) ? Helpers::Admin() : Helpers::User()
     end
   end
 end
