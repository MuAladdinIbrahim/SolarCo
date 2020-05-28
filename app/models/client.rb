class Client < User
    has_one_attached :avatar

    # Returns the url path for the avatar blob
    def avatar_url
        Rails.application.routes.url_helpers.rails_blob_path(self.avatar, only_path: true) unless self.avatar.attachment.nil?
    end
end
