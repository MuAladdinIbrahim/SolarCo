class System < ApplicationRecord
    has_one :calculation, dependent: :destroy
    has_one :post, dependent: :destroy
    belongs_to :user

    validates :user, :consumption, :latitude, :city, :country, presence: true
    validates :consumption, numericality: { greater_than: 0 }
    validates :address, length: {maximum: 500}

    PRICE_PER_WH = 3 #Cost per doller
    EG_PER_DOLLER = 16.5 

    def published? (sys_id)
        true if Post.find_by(system_id: sys_id)
    end

    def onOffer? (system)
        unless (system.post).nil?
            true if Offer.find_by(post_id: (system.post.id))
        end
    end

    # def getCalculationsId(systems)
    #     sys = [];
    #     systems.each do |system|
    #         sys << {"system" => system, "cost" => estimatedCost(system), "calculation_id" => system.calculation.id} if !system.nil?
    #     end
    #     sys
    # end

    def cost
        wh_per_day = self.consumption/30.to_f*1000
        if self.latitude.abs() < 70
          gen_factor = ((90/self.latitude.abs()) * 1.75).ceil(2) if self.latitude.abs() > 25 || 6.4 #Generation Factor ~ sun rise hours
        else
            gen_factor = 1
        end
        tot_power = (wh_per_day*1.35 / gen_factor).ceil(-2)

        if self.backup
            (tot_power * PRICE_PER_WH * EG_PER_DOLLER * 0.25).ceil(2)
        else
            (tot_power * PRICE_PER_WH * EG_PER_DOLLER * 1.07).ceil(2)
        end
    end

end
