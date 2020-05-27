class ClientController < ApplicationController
    before_action :set_user, only: [:updateAvatar]

    # PATCH/PUT /clients/avatar/1
    def updateAvatar
        if @client.update(avatar: params[:avatar])
            render json: @client
        else
            render json: @client.errors, status: :unprocessable_entity
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @client = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
        params.require(:client).permit(:avatar)
    end
end
