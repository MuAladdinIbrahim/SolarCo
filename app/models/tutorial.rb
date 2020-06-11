class Tutorial < ApplicationRecord
  belongs_to :contractor
  belongs_to :category
  has_many :likes
  has_many :comments

  validates :contractor, presence: true
  validates :category, presence: true
  validates :title, length: { in: 5..35 }
  validates :body, length: { minimum: 50 } 

end
