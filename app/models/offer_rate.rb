class OfferRate < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  validates :rate, numericality: { greater_than: 0, less_than: 6 }

  def getRates(offers)
    offer_rates = []
    offers.as_json(methods: :offer_rate).each do |offer|
      offer_rates << offer['offer_rate'] if !offer['offer_rate'].nil?
    end
    offer_rates
  end
end
