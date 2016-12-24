module SubscriptionHelper
  def self.get_end_date(start_date, duration)
    case duration
    when '1W'
      start_date + 7
    when '1M'
      start_date >> 1
    when '1Y'
      start_date >> 12
    else
      start_date >> 1
    end
  end

  def self.get_amount_in_cent(duration)
    (self.get_amount(duration) * 100).to_i
  end

  def self.get_amount(duration)
    case duration
    when '1W'
      amount = 22.15
    when '1M'
      amount = 73.00
    when '1Y'
      amount = 803.00
    else
      amount = 73.00
    end
    amount
  end

  def self.get_payment_description(duration)
    case duration
    when '1W'
      'Abonnement 1 semaine'
    when '1M'
      'Abonnement 1 mois'
    when '1Y'
      'Abonnement 1 an'
    else
      'Abonnement 1 mois'
    end
  end

  def self.get_duration_label(duration)
    case duration
    when '1W'
      '1 semaine'
    when '1M'
      '1 mois'
    when '1Y'
      '1 an'
    else
      '1 mois'
    end
  end

  def self.is_valid(end_date)
    Date.new(end_date.year, end_date.month, end_date.day) > Date.current
  end

  def self.is_waiting(start_date)
    Date.new(start_date.year, start_date.month, start_date.day) > Date.current
  end
end
