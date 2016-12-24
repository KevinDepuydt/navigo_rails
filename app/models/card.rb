require 'securerandom'

class Card < ApplicationRecord
  before_create :set_auth_token

  belongs_to :user
  has_many :subscriptions

  validates_presence_of :number
  validates_length_of :number, is: 13, message: 'Le numéro d\'une carte est de 13 caractères'

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
