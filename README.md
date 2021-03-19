# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

  2.4.2

* System dependencies

* Configuration

* Database creation

  Postgresql

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# Setup

Just hit 
* bundle install
* rails db:create db:migrate

# Testing

I have only created an API and so the testing could be done by using Postman or any of the same platform. This has been done through TDD approach which means you may also run the test by executing `RAILS_ENV=test bundle exec rspec spec/requests/reservations_controller_spec.rb`

I used the two payloads given from the example to write test cases.
