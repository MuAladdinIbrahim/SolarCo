# frozen_string_literal: true

class Contractor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_one :offer
  has_many :offer_rates, through: :offer
  has_many :offer_reviews, through: :offer
  has_one_attached :avatar

  # Returns the url path for the avatar blob
  def avatar_url
      self.avatar.attachment.nil? ? '' :
      "#{Rails.configuration.api_url}#{Rails.application.routes.url_helpers.rails_blob_path(self.avatar, only_path: true)}"
  end

  def as_json(options={})
    super(options).merge({
        rules: Ability.new(self).as_json,
        avatar: self.avatar_url
    })
  end
end
