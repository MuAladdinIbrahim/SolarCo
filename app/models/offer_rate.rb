class OfferRate < ApplicationRecord
  belongs_to :contractor
  belongs_to :offer
end
