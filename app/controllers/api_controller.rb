class ApiController < ApplicationController
  #before_action :authenticate_user, only: [:renew_subscription]
  before_action :authenticate_card, only: [:check_card_subscriptions, :new_card_subscription]
  before_action :validate_params, only: [:new_card_subscription]

  def check_card_subscriptions
    if @card.nil?
      render json: { message:'Cette carte est introuvable' }, status: 404
    else
      if CardSubscriptions.is_valid(@card)
        render json: { message:'Cette carte possède un abonnement en cours de validité' }, status: 200
      else
        render json: { message:'Cette carte ne possède pas d\'abonnement en cours de validité' }, status: 200
      end
    end
  end

  def new_card_subscription
    @start_date = @card.subscriptions.last.end_at || Date.current
    @end_date = SubscriptionHelper.get_end_date(@start_date, @duration)
    @amount = SubscriptionHelper.get_amount(@duration)

    subscription = Subscription.create(amount: @amount,
                        start_at: @start_date,
                        end_at: @end_date,
                        duration: @duration,
                        card_id: @card.id)

    if subscription.persisted?
      render json: { message: "L'abonnement de la carte #{@card.number} à bien été validé jusqu'au #{@end_date.strftime('%d/%m/%Y')}" }, status: 200
    else
      render json: { message: 'Une erreur est survenue lors de la validation de l\abonnement' }, status: 400
    end
  end

  protected

  def authenticate_user
    authenticate_user_token || render_unauthorized
  end

  def authenticate_card
    authenticate_card_token || render_unauthorized
  end

  def authenticate_user_token
    authenticate_or_request_with_http_token do |token, options|
      @user = User.find_by auth_token: token
    end
  end

  def authenticate_card_token
    authenticate_or_request_with_http_token do |token, options|
      @card = Card.find_by auth_token: token
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end

  def validate_params
    @duration = params[:duration]

    if @duration.nil?
      render json: { message: 'Missing duration param' }, status: 400
    elsif not %w(1W 1M 1Y).include?(@duration)
      render json: { message: 'Wrong duration (1 week = 1W, 1 month = 1M, 1 year = 1Y)' }, status: 400
    end
  end

end
