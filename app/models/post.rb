class Post < ApplicationRecord
    belongs_to :user
    validates :user, presence: true
    belongs_to :system
    validates :system, presence: true
    validates :user, presence: true
    validates :title, length: { in: 6..35 }
    validates :description, length: { minimum: 200 }
end