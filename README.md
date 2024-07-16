# README

# Loom Video of the whole project
https://www.loom.com/share/36447108f5174c82b74f430f6da3f796?sid=ad357dbb-1300-42b6-81f1-0ec373fa5011

# Longleaf Lending Profit Calculator

This is a Ruby on Rails application for Longleaf Lending that provides a lead generation form and a profit calculator. The application collects user input, calculates estimated profits, generates a termsheet PDF, and emails the PDF to the user.

## Features and Implementation Strategy

- I follow a simple incremental approach to implement the small calculator.
- Collect user input through a form
- Calculate estimated profits based on input details
- Generate a PDF
- Email the generated PDF to the user
- Use Sidekiq for background job processing
- Use Tailwind CSS for styling

## Requirements

- Ruby 3.1.0
- Rails 7.x
- Redis (for Sidekiq)
- PostgreSQL (or any other database supported by Rails)

## Improvements need to be made

- Currently, I am saving the generated PDF in the public folder, but we can upload it to an S3 bucket and then download it from S3. This will be a scalable solution.
- I am currently following the Rails conventional approach, but we can use different design patterns to improve our code quality.
- We can write test cases to ensure code extensibility.

## Setup Instructions

```sh
git clone https://github.com/NabeelMinhas/profit-calculator
cd profit-calculator

bundle install
yarn install --check-files

rails db:create
rails db:migrate

Add these environment variables

EMAIL_USERNAME=your_email@gmail.com
EMAIL_PASSWORD=your_email_password 
HOST=your_host_url

brew install redis
redis-server

bundle exec sidekiq

bin/dev
