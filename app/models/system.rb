class System < ApplicationRecord
    has_one :calculation
    has_one :post
    belongs_to :user
    validates :user, presence: true

    def published? (sys_id)
        true if Post.find_by(system_id: sys_id)
    end
    
end
