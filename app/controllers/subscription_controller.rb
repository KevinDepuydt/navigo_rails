class SubscriptionController < ApplicationController
  before_action :authenticate_user!
  before_action :init, only: [:index, :show, :new, :create, :validate_user]
  before_action :validate_user

  def index
    @subscriptions = @card.subscriptions.reverse
  end

  def show
    @subscription = @card.subscriptions.find(params[:id])
  end

  def new
    @amount = SubscriptionHelper.get_amount(@duration)
    @amount_in_cent = SubscriptionHelper.get_amount_in_cent(@duration)
    @description = SubscriptionHelper.get_payment_description(@duration)
  end

  def create
    subscription = @card.subscriptions.last
    if subscription.nil? || subscription.end_at <= Date.current
      puts "Subscription params #{params}"
      payment = SubscriptionPayment.pay(@card, params)
      if payment.success?
        last_subscription = @card.subscriptions.last
        redirect_to subscription_path(last_subscription.id), success: 'Votre abonnement a bien été renouvelé'
      else
        redirect_to new_card_subscription_path(@duration), error: payment.error_message
      end
    else
      redirect_to subscription_path(subscription.id), error: 'Votre abonnement est déjà à jour'
    end
  end

  private

  def init
    @card = Card.find(current_user.card.id)
    @duration = params[:duration]
  end

  def validate_user
    if current_user.card.nil? || current_user.id != @card.user_id
      redirect_to root_path, error: 'Vous n\'avez pas l\'autorisation d\'acceder à cette page'
    end
  end
end
