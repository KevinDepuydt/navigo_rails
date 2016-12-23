class Card < ApplicationRecord
  belongs_to :user
  has_many :subscriptions

  validates_presence_of :number
  validates_length_of :number, is: 13, message: 'Le numéro d\'une carte est de 13 caractères'
end
