class User < ApplicationRecord
    has_many :systems

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
            rules: Ability.new(self).as_json
        })
    end
end