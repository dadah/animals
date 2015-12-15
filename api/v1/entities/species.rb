module Animals
  module Api
    module V1
      module Entities
        class Species < Grape::Entity
          expose :id
          expose :name
        end
      end
    end
  end
end
