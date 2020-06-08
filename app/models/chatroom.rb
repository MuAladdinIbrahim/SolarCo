class Chatroom < ApplicationRecord
  # belongs_to :user
  # belongs_to :contractor
  has_many :messages, dependent: :destroy
  has_one :user, through: :messages
  has_one :contractor, through: :messages
end
