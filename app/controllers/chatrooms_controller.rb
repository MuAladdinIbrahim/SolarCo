class ChatroomsController < ApplicationController

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
