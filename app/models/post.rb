class Post < ApplicationRecord
    belongs_to :user
    validates :user, presence: true
    belongs_to :system
    has_many :offers
    validates :system, presence: true
    validates :title, length: { in: 6..35 }
    validates :description, length: { minimum: 100 }
    has_many :offer
end