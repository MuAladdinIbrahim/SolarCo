class Offer < ApplicationRecord
  belongs_to :contractor
  belongs_to :post

  enum status: [:accepted, :rejected]

  validates :proposal, :price, presence: true
end
