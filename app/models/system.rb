class System < ApplicationRecord

    def publish(sys_obj)
        sys_obj.update(status: 'published')
    end
    
end
