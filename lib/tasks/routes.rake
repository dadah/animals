namespace :api do
  desc "API Routes"
  task routes: :environment do
    Animals::Api.routes.each do |api|
      method = api.route_method.ljust(10)
      path = api.route_path
      path = path.gsub(":version", api.route_version) if api.route_version.present?
      puts "     #{method} #{path}"
    end
  end
end
