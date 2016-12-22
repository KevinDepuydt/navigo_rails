class SubscriptionPayment
  def initialize(card, params)
    @params = params
    @card = card
  end

  def self.pay(card, params)
    self.new(card, params).pay
  end

  def success?
    @success
  end

  def pay
    @duration = @params[:duration]
    @start_date = Date.current
    @end_date = SubscriptionHelper.get_end_date(@start_date, @duration)
    @amount = SubscriptionHelper.get_amount(@duration)
    @amount_in_cent = SubscriptionHelper.get_amount_in_cent(@duration)

    customer = Stripe::Customer.create(:email => @params[:stripeEmail],
                                       :source  => @params[:stripeToken])

    charge = Stripe::Charge.create(:customer    => customer.id,
                                   :amount      => @amount_in_cent,
                                   :description => 'Rails Stripe customer',
                                   :currency    => 'eur')

    puts "Charge #{charge}"

    Subscription.create(amount: @amount,
                        start_at: @start_date,
                        end_at: @end_date,
                        duration: @duration,
                        card_id: @card.id)

    @success = true
    self
  rescue Stripe::CardError => e
    @success = false
    @error_message = e.message
    self
  end

  private

  attr_reader :card, :error_message
end