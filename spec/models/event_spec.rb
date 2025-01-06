require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user1) { User.create!(email: "user1@example.com", password: "password") }
  let(:user2) { User.create!(email: "user2@example.com", password: "password") }
  let(:event) { FactoryBot.create(:event, name: "Concert", total_tickets: 20, user: user1) }

  context '#success' do
    it "handles optimistic locking with retries when tickets are available" do
      thread1 = Thread.new do
        event.book_tickets(user1, 5)
      end

      thread2 = Thread.new do
        event.book_tickets(user2, 3)
      end

      thread1.join
      thread2.join

      expect(event.reload.available_tickets).to eq(12)
      expect(event.tickets.sum(:quantity)).to eq(8)
    end
  end

  context '#failure' do
    it "handles optimistic locking with retries when tickets are sold out" do
      thread1 = Thread.new do
        event.book_tickets(user1, 20)
      end

      thread2 = Thread.new do
        expect {
          event.book_tickets(user2, 3)
        }.to raise_error(RuntimeError, "Tickets sold out!")
      end

      thread1.join
      thread2.join

      expect(event.reload.available_tickets).to eq(0)
      expect(event.tickets.sum(:quantity)).to eq(20)
    end
  end
end
