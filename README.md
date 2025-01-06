# Ticket Booking System

A simple event ticket booking system built with Ruby on Rails. This application allows users to create events, book tickets, and handle concurrency issues during ticket booking.

---

## Features

- **User Authentication**: Users can register, log in, and log out using Devise.
- **Event Management**:
    - Create events with details like name, description, location, date, and total tickets available.
    - View a list of all events.
- **Ticket Booking**:
    - Book tickets for events while ensuring no overselling using optimistic locking.
    - Concurrency handling with retries for conflict resolution.
- **Pagination**: Paginated views for events and tickets.
- **Error Handling**: Friendly error messages for ticket booking conflicts.

---

## Setup Instructions

### 1. Clone the Repository
```bash
https://github.com/jaspreet-3911/ticket-booking.git
```
### 2. Install Dependencies
```bundle install```


### 3. Set Up the Database
```bash
rails db:create
rails db:migrate
```


### 4. Start the Server
```bash
rails server
```

### 5. Access the Application
```bash
http://localhost:3000
```


### 5. Testing
```bash
bundle exec rspec
```