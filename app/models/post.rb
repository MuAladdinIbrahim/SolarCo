class Post < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  tracked recipient: ->(controller, model) { model && model.user }
  belongs_to :user
  validates :user, presence: true
  belongs_to :system
  has_many :offers
  validates :system, presence: true
  validates :title, length: { in: 6..35 }
  validates :description, length: {in: 0..1000}

  def validate_create_offer(current_contractor, post)
      if post.contractor = current_contractor
        false
      else
        true
      end
  end
end