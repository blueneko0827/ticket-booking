class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_destroy :update_event

  private

  def update_event
    Event.transaction do
      locked_event = Event.lock.find(event.id)
      locked_event.increment!(:available_tickets, quantity)
    end
  end
end
