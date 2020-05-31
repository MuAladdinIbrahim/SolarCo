class Client < User
    has_one_attached :avatar

    # Returns the url path for the avatar blob
    def avatar_url
        self.avatar.attachment.nil? ? '' :
        "#{Rails.configuration.api_url}#{Rails.application.routes.url_helpers.rails_blob_path(self.avatar, only_path: true)}"
    end

    def as_json(options={})
        super(options).merge({
            avatar: self.avatar_url
        })
    end

end
