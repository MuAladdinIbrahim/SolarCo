class MessageBroadcastJob < ApplicationJob
  # queue_as :default

  # def perform(message)
  #   ActionCable.server.broadcast 'room_channel', message: render_message(message)
  # end

  # private

  # def render_message(message)
  #   # ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  # end
  queue_as :default

  def perform(message)
    payload = {
      content: message.content,
      sender: message.messagable
    }
    puts "perform in job"
    ActionCable.server.broadcast "ChatRoom-#{message.chatroom.user_id}-with-#{message.chatroom.contractor_id}",
    message: payload
  end
end
