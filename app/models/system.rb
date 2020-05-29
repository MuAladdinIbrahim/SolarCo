class System < ApplicationRecord
    enum status: [:unpublished, :published]

    def publish(sys_obj)
        sys_obj.update(status: 'published')
    end
end
