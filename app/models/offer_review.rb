class OfferReview < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  def getReviews(offers)
    offer_reviews = []
    offers.as_json(methods: :offer_review).each do |offer|
      offer_reviews << offer['offer_review'] if !offer['offer_review'].nil?
    end
    offer_reviews
  end

end
