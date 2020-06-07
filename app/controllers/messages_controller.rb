class MessagesController < ApplicationController
    def index
        @chatroom = Chatroom.find_by(user_id: params[:user_id], contractor_id: params[:contractor_id])

        if @chatroom
            render json: @chatroom.messages.as_json
        end
    end
    
    private

        def message_params
            params.require(:message).permit(:content, :chatroom_id)
        end
end
