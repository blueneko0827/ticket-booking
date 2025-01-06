class TicketsController < ApplicationController
  def index
    @tickets = current_user.tickets.includes(:event).order(created_at: :asc).page(params[:page]).per(20)
  end

  def create
    event = Event.find(params[:event_id])
    quantity = params[:quantity].to_i

    begin
      event.book_tickets(current_user, quantity)
      redirect_to event_path(event), notice: "Successfully booked #{quantity} tickets."
    rescue => e
      redirect_to event_path(event), alert: e.message
    end
  end

  def destroy
    @ticket = current_user.tickets.find(params[:id])
    if @ticket.destroy
      redirect_to tickets_path, notice: "Ticket deleted successfully."
    else
      redirect_to events_path
    end
  end
end
