require 'securerandom'

namespace :db do
  desc 'Import users from data file'
  task import_users: :environment do
    user_file_path = './db/data/users.lst'
    File.open(user_file_path, 'r').each_line do |line|
      # User data
      last_name, first_name = line.split(/\s/)
      email = "#{first_name.downcase}.#{last_name.downcase}@mail.fr"
      secure_password = Digest::SHA256.hexdigest(SecureRandom.hex(8))

      # Check for existing email
      email_found_index = 1
      while User.exists?(email: email)
        email = "#{first_name.downcase}.#{last_name.downcase}.#{email_found_index.to_s}@mail.fr"
        email_found_index += 1
      end

      # Create user
      user = User.create({
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: secure_password
      })

      if user.persisted?
        puts "User ##{user.id} saved"
      end
    end
  end

  desc 'Import cards from data file'
  task import_cards: :environment do
    card_file_path = './db/data/cards.lst'
    File.open(card_file_path, 'r').each_line do |card_number|
      card = Card.create(number: card_number.gsub(/\n/, ''))
      if card.persisted?
        puts "Card ##{card.id} saved"
      end
    end
  end

  desc 'Link cards to users'
  task link_cards_to_users: :environment do
    # Find the n = User.count cards
    User.find_each do |user|
      # Check if user is already linked to card
      unless Card.where(user_id: user.id).first
        # Then update first card without user_id
        card = Card.where(user_id: nil).first
        if card
          card.update_attribute(:user_id, user.id)
          puts "Card #{card.id} linked to user #{user.id}"
        end
      end
    end
  end

  desc 'Clean db'
  task clean: :environment do
    # Delete all users
    User.delete_all
    # Delete all cards
    Card.delete_all
    # Delete all subscriptions
    Subscription.delete_all
  end
end
