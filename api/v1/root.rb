module Animals
  module Api
    module V1
      class Root < Grape::API
        mount Animals::Api::V1::Pets
        mount Animals::Api::V1::Species
      end
    end
  end
end
