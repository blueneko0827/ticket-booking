class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy

  validates :name, :description, :location, :date, :total_tickets, presence: true
  before_create :init_available_tickets

  MAX_RETRIES = 3 # Maximum number of retry attempts

  def book_tickets(user, quantity)
    retries = 0

    begin
      transaction do
        reload
        raise "Tickets sold out!" if available_tickets == 0
        raise "Exceeded available tickets!" if available_tickets < quantity

        update!(available_tickets: available_tickets - quantity)
        tickets.create!(user: user, quantity: quantity)
      end
    rescue ActiveRecord::StaleObjectError
      retries += 1
      if retries <= MAX_RETRIES
        Rails.logger.warn("Retrying booking for user #{user.id}, attempt ##{retries}")
        retry
      else
        raise "Ticket booking conflict. Please try again later."
      end
    end
  end

  def init_available_tickets
    self.available_tickets = total_tickets
  end
end
