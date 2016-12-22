class CardSubscriptions
  def initialize(card)
    @card = card
    @subscriptions = @card.subscriptions
    @last_subscription = @subscriptions.last
  end

  def self.is_valid(card)
    self.new(card).is_valid
  end

  def is_valid
    if @last_subscription
      date_to_test = Date.new(@last_subscription.end_at.year, @last_subscription.end_at.month, @last_subscription.end_at.day)
      date_to_test > Date.current
    else
      false
    end
  end
end