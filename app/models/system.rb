class System < ApplicationRecord
    has_one :calculation

    def publish(sys_obj)
        sys_obj.update(status: 'published')
    end
    
end
