class ApiController < ActionController::API
	include PublicActivity::StoreController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include ActionController::Caching

end
