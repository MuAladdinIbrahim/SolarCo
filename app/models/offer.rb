class Offer < ApplicationRecord
  belongs_to :contractor
  belongs_to :post
  has_many :offer_rates
  has_many :offer_reviews
  
  enum status: [:accepted, :rejected]

  validates :proposal, :price, presence: true
end
