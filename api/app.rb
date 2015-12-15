module Animals
  module Api
    class App < Grape::API
      def self.setup_application!
        return if @_configured
        require_dependencies
        error_formatter :json, Animals::Api::ErrorFormatter
        mount Animals::Api::V1::Root
        @_configured = true
      end
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        handler = lambda {|arg| error_response(arg)}
        exec_handler(e, &handler)
      end
      rescue_from :all
    end
  end
end
