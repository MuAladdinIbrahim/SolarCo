class Post < ApplicationRecord
    belongs_to :user
    validates :user, presence: true
    belongs_to :system
    has_many :offers
    validates :system, presence: true
    validates :title, length: { in: 6..35 }
    validates :description, length: { minimum: 50 }

    def validate_create_offer(current_contractor, post)
        if post.contractor = current_contractor
          false
        else
          true
        end
    end

    # def Reviews
    #   # off_id = nil
    #   (self.offers).each do |offer|
    #     if offer.status = 'accepted'
    #       puts offer.id
    #       rate = OfferRate.find_by(offer_id: offer.id) 
    #       review = OfferReview.find_by(offer_id: offer.id) 
    #       return {"rate" => rate, "comment" => review}
    #     end
    #   end
    # end
end