class ChatroomsController < ApplicationController
    # before_action :authenticate_user!, only [:clientChats]
    # before_action :authenticate_contractor!, only [:contractorChats]

    def clientChats
        @chatrooms = Chatroom.where(user_id: params[:id])

        if @chatrooms
            render json: @chatrooms.as_json(include: :messages)
        end
    end

    def contractorChats
        @chatrooms = Chatroom.where(contractor_id: params[:id])

        if @chatrooms
            render json: @chatrooms.as_json(include: :messages)
        end
    end

end
