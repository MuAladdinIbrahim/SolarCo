class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :messagable, polymorphic: true

  validates_presence_of :content

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  def as_json(options={})
      super(options).merge({
          sender: self.messagable
      })
  end
end
