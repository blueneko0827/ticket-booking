class EventsController < ApplicationController
  def index
    @events = Event.order(created_at: :asc).page(params[:page]).per(20)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event created successfully."
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to @event, notice: "Event deleted successfully."
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :date, :total_tickets)
  end
end
