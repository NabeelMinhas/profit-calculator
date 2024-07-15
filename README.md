# README

# Loom Video of the whole project
https://www.loom.com/share/fd4506488a044146bcc4487a86e52fa5?sid=c1a1b32f-4175-4302-9316-669eda0a5f18

# Longleaf Lending Profit Calculator

This is a Ruby on Rails application for Longleaf Lending that provides a lead generation form and a profit calculator. The application collects user input, calculates estimated profits, generates a termsheet PDF, and emails the PDF to the user.

## Features

- Collect user input through a form
- Calculate estimated profits based on input details
- Generate a termsheet PDF
- Email the generated PDF to the user
- Use Sidekiq for background job processing
- Use Tailwind CSS for styling

## Requirements

- Ruby 3.1.0
- Rails 7.x
- Redis (for Sidekiq)
- PostgreSQL (or any other database supported by Rails)

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
