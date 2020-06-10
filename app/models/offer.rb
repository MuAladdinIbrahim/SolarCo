class Offer < ApplicationRecord
  belongs_to :contractor
  belongs_to :post, :counter_cache => true
  has_one :offer_rate, dependent: :destroy
  has_one :offer_review, dependent: :destroy
  
  enum status: [:accepted, :rejected]

  validates :proposal, :price, presence: true
  
end
