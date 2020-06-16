class OfferReview < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  validates :review, presence: true
  validates :review, length: {in: 1..250}

  def getReviews(offers)
    offer_reviews = []
    offers.as_json(methods: :offer_review).each do |offer|
      offer_reviews << offer['offer_review'] if !offer['offer_review'].nil?
    end
    offer_reviews.reverse 
  end

end
