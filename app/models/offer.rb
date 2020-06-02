class Offer < ApplicationRecord
  belongs_to :contractor
  belongs_to :post

  enum status: { accepted: 0, rejected: 1 }

  validates :proposal, :price, presence: true
end
