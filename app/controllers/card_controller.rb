class CardController < ApplicationController
  before_action :authenticate_user!, except: [:check_card_subscriptions]

  def provide_card_number
  end

  def link_card_to_user
    redirect_to root_path, error: 'Une carte est déjà associée à votre compte' if current_user.card

    card = Card.where(number: params[:number]).first

    if card
      if card.user_id
        redirect_to provide_card_number_path, error: 'Cette carte est déjà reliée à un autre compte'
      else
        card.update_attribute(:user_id, current_user.id)
        redirect_to root_path, success: 'La carte a été reliée à votre compte avec succès'
      end
    else
      redirect_to provide_card_number_path, error: 'Ce numéro ne correspond à aucune carte'
    end
  end

  def check_card_subscriptions
    card = Card.where(number: params[:number]).first

    puts "Card #{card}"

    if card.nil?
      redirect_to root_path, error: 'Ce numéro ne correspond à aucune carte'
    else
      puts "Condition #{CardSubscriptions.is_valid(card)}"
      if CardSubscriptions.is_valid(card)
        redirect_to root_path, notice: 'Cette carte possède un abonnement en cours de validité'
      else
        redirect_to root_path, notice: 'Cette carte ne possède pas d\'abonnement en cours de validité'
      end
    end
  end

end
