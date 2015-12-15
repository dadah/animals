module Animals
  module Api
    module V1
      class Species < Grape::API
        version 'v1'
        format :json
        resources :species do
          get do
            present ::Species.all, with: Animals::Api::V1::Entities::Species
          end
        end
      end

    end
  end
end
