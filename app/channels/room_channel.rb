class RoomChannel < ApplicationCable::Channel

    def speak(data)
        if data['message']
            if current_user
                puts @chatroom.id
                message = current_user.messages.create!(content: data['message'], chatroom_id: @chatroom.id)
                puts "message #{message.messagable_type}"
            elsif current_contractor
                puts current_contractor
                message = current_contractor.messages.create!(content: data['message'], chatroom_id: @chatroom.id)
            end
        
            # if message.save!
            # #   # do some stuff
            #   puts "message saved"
            # else 
            # # #   redirect_to chatrooms_path
            #     puts message.id
            # end
            # Message.create! (content: data['message'], chatroom_id: @chatroom.id)
        end
    end
    # calls when a client connects to the server
  def subscribed
    if params[:user_id].present? && params[:contractor_id].present?
        puts "ChatRoom-#{(params[:user_id])}-with-#{(params[:contractor_id])}"
        puts findOrCreateRoom(params[:user_id], params[:contractor_id])
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
  
  # calls when a client broadcasts data
#   def speak(data)
#     sender    = get_sender(data)
#     room_id   = data['room_id']
#     message   = data['message']

#     raise 'No room_id!' if room_id.blank?
#     convo = get_convo(room_id) # A conversation is a room
#     raise 'No conversation found!' if convo.blank?
#     raise 'No message!' if message.blank?

#     # adds the message sender to the conversation if not already included
#     convo.users << sender unless convo.users.include?(sender)
#     # saves the message and its data to the DB
#     # Note: this does not broadcast to the clients yet!
#     Message.create!(
#       conversation: convo,
#       sender: sender,
#       content: message
#     )
#   end
  
#   # Helpers
  
#   def get_convo(room_code)
#     Chatroom.find(room_code)
#   end
  
#   def get_sender
#     if current_user
#         current_user
#     elsif current_contractor
#         current_contractor
#     end
#   end
end