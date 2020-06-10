class RoomChannel < ApplicationCable::Channel

    def speak(data)
        if data['message']
            if current_user.is_a? User
                message = current_user.messages.create!(content: data['message'], chatroom_id: @chatroom.id)
            elsif current_user.is_a? Contractor
                message = current_user.messages.create!(content: data['message'], chatroom_id: @chatroom.id)
            end
        end
    end

    # calls when a client connects to the server
    def subscribed
        if params[:user_id].present? && params[:contractor_id].present?
            findOrCreateRoom(params[:user_id], params[:contractor_id])
            # creates a private chat room with a unique name
            stream_from("ChatRoom-#{(params[:user_id])}-with-#{(params[:contractor_id])}")
        end
    end

    def findOrCreateRoom(user, contractor)
        @chatroom = Chatroom.find_by(user_id: user, contractor_id: contractor)

        if @chatroom
            @chatroom
        else
            @chatroom = Chatroom.create({user_id: user, contractor_id: contractor})
        end
    end
end