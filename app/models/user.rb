class User < ApplicationRecord
    has_many :systems, dependent: :destroy
    has_many :offer_rates
    has_many :offer_reviews
    # has_many :calculations, through: :systems
    has_many :messages, as: :messagable
    has_many :chatrooms, through: :messages, dependent: :destroy
    has_one :like
    has_many :comments

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