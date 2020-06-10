class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    payload = {
      content: message.content,
      sender: message.messagable,
      messagable_type: message.messagable_type
    }
    
    ActionCable.server.broadcast "ChatRoom-#{message.chatroom.user_id}-with-#{message.chatroom.contractor_id}",
    message: payload
  end
end
