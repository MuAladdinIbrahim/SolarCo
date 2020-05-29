class System < ApplicationRecord
    has_one :calculation
    belongs_to :user

    def publish(sys_obj)
        sys_obj.update(status: 'published')
    end
    
end
