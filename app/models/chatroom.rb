class Chatroom < ApplicationRecord
  # belongs_to :user
  # belongs_to :contractor
  has_many :messages, dependent: :destroy
  has_one :user, through: :messages
  has_one :contractor

  def as_json(options={})
    super(options).merge({
      user: User.find(self.user_id),
      contractor: Contractor.find(self.contractor_id)
    })
  end
end
