class Tutorial < ApplicationRecord
  belongs_to :contractor
  has_many :likes
  has_many :comments
  has_and_belongs_to_many :tags
end
