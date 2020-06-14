class Tutorial < ApplicationRecord
  belongs_to :contractor
  belongs_to :category
  has_many :likes
  has_many :comments
  has_many :favorites
  has_many :users, through: :favorites

  validates :title, presence: true
  validates :body, presence: true
  validates :contractor, presence: true
  validates :category, presence: true
  validates :title, length: { in: 5..35 }
  validates :body, length: { in: 50..2000 } 

end
