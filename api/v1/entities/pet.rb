module Animals
  module Api
    module V1
      module Entities
        class Pet < Grape::Entity
          expose :id
          expose :name
        end
      end
    end
  end
end
