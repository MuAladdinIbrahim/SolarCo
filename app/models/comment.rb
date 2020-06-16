class Comment < ApplicationRecord
  belongs_to :tutorial
  belongs_to :user

  validates :review, length: {in: 1..800}
end
