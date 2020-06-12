class Message < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { model && model.messagable }
  tracked recipient: ->(controller, model) { model && model.getRecipient }
  
  belongs_to :chatroom
  belongs_to :messagable, polymorphic: true

  validates_presence_of :content

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  def as_json(options={})
      super(options).merge({
          sender: self.messagable
      })
  end

  def getRecipient
    @chatroom = Chatroom.find(chatroom_id)

    if self.messagable_type == 'User'
      Contractor.find(@chatroom.contractor_id)
    elsif self.messagable_type == 'Contractor'
      User.find(@chatroom.user_id)
    end
  end
end
