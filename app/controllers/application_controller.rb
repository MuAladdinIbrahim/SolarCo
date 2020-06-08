class ApplicationController < ActionController::Base
	# protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token

#   def members_only
#     render json: {
#       data: {
#         message: "Welcome #{current_member.name}",
#         user: current_member
#       }
#     }, status: 200
#   end

	# include DeviseTokenAuth::Concerns::SetUserByToken

	# before_action :configure_permitted_parameters, if: :devise_controller?

	#  protected

	#  def configure_permitted_parameters
	#  	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :type, :has_office, :address, :mobileNumber, :fax, :website])
	#  	devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :type, :has_office, :address, :mobileNumber, :fax, :website])
	#  end
end
