class Contact < ApplicationRecord

    validates :name, :email, :message, :phone, presence: true
end
