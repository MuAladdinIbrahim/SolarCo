# frozen_string_literal: true

class Contractor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :offers
  has_many :offer_rates, through: :offers
  has_many :offer_reviews, through: :offers
  has_one_attached :avatar
  has_many :messages, as: :messagable
  has_many :chatrooms, through: :messages, dependent: :destroy
  has_many :tutorials

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

  def tutCount
    Tutorial.where(contractor_id: self.id).count
  end

  def likes

  end
end
