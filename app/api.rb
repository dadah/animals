module Animals
  class Api < Grape::API
    get :hello do
      { hello: "World" }
    end
  end
end
