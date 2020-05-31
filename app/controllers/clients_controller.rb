class ClientsController < ApplicationController
    before_action :set_user, only: [:updateAvatar, :show, :update]

    # PATCH/PUT /clients/avatar/1
    def updateAvatar
        if @client.update(avatar: params[:avatar])
            render :json => @client
        else
            render json: @client.errors, status: :unprocessable_entity
        end
    end

    # GET /clients/1
    def show
        # Call the method avatar_url to send its return value with the response
        render :json => @client.as_json(methods: :avatar_url)
    end

    def update
        if @client.update(uid: params['email'], email: params['email'], name: params['name'])
            render json: @client
        else
            render json: @client.errors, status: :unprocessable_entity
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
        params.require(:client).permit(:avatar)
    end
end
