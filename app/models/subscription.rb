class Subscription < ApplicationRecord
  belongs_to :card

  validates_presence_of :card, :amount, :duration, :start_at, :end_at
end
