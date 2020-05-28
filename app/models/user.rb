class User < ApplicationRecord
    extend Devise::Models
    devise :database_authenticatable, 
    :registerable,
    :recoverable, 
    :rememberable, 
    :trackable,  
    :validatable, 
    :omniauthable
    include DeviseTokenAuth::Concerns::User

    def as_json(options={})
        super(options).merge({
            type: self.type
        })
    end
end