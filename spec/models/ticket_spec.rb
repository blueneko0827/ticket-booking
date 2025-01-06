require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:user) { User.create!(email: "user@example.com", password: "password") }
  let(:event) { FactoryBot.create(:event, name: "Concert", total_tickets: 20, user: user) }

  it "updates the event's available tickets safely with locking" do
    ticket = event.book_tickets(user, 20)
    expect(event.available_tickets).to eq(0)
    thread1 = Thread.new { ticket.destroy }
    thread2 = Thread.new { event.book_tickets(user, 10) }

    thread1.join
    thread2.join

    event.reload
    expect(event.available_tickets).to eq(10)
  end
end
