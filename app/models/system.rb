class System < ApplicationRecord
    has_one :calculation, dependent: :destroy
    has_one :post, dependent: :destroy
    belongs_to :user

    validates :user, :consumption, :latitude, :city, :country, presence: true
    validates :consumption, numericality: { greater_than: 0 }

    def published? (sys_id)
        true if Post.find_by(system_id: sys_id)
    end

    def getCalculationsId(systems)
        sys = [];
        systems.each do |system|
            sys << {"system" => system, "calculation_id" => system.calculation.id}
        end
        sys
    end


end
