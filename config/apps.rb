##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, '672bf41091f648d408051980c238224a63b1e57b277fd662ad10af772b206de6'
  set :protection, :except => :path_traversal
  set :protect_from_csrf, true
end

# Mounts the core application for this project

Padrino.mount("Animals::Admin", :app_file => Padrino.root('admin/app.rb')).to("/admin")
Padrino.mount('Animals::Api::App', :app_file => Padrino.root('api/app.rb')).to('/').host(/api.*/)
Padrino.mount('Animals::App', :app_file => Padrino.root('app/app.rb')).to('/')
