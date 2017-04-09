Warden::Manager.after_set_user do |user,auth,opts|
  scope = opts[:scope]
  auth.cookies["#{scope}.id"] = user.id
  auth.cookies["#{scope}.admin"] = user.admin
end
