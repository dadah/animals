module Animals
  module Api
    class App < Grape::API
      def self.setup_application!
        require_dependencies
        error_formatter :json, Animals::Api::ErrorFormatter
        mount Animals::Api::V1::Root
      end
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        handler = lambda {|arg| error_response(arg)}
        exec_handler(e, &handler)
      end
      rescue_from :all
    end
  end
end
