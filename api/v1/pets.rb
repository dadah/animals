module Animals
  module Api
    module V1
      class Pets < Grape::API
        version 'v1'
        format :json
        resources :pets do
          get do
            present Pet.all, with: Animals::Api::V1::Entities::Pet
          end
        end
      end
    end
  end
end
