# README

Whether, Sweater? is an application designed to tell you the forecast for any given location. You can create a user account, login and even create roadtrips. When you do that we will tell you how long the trip will take and the expected forecast for your destination

## Learning Goals
- Expose an API that aggregates data from multiple external APIs

- Expose an API that requires an authentication token

- Expose an API for CRUD functionality

- Determine completion criteria based on the needs of other developers

- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).


## How can someone clone and set up the app?
- Fork then clone this repository to your local machine

- Run "bundle install"

- If you have the mast key, create "config/master.key" and put it in there 

- Otherwise, delete the credentials.yml file that currently exists and get api keys for yourself

## Where they can get their own API Keys
- Go to "https://www.weatherapi.com/" and create an account to get an api, it should be located on your dashboard

- Go to "https://developer.mapquest.com/" and create an account to get an api key, it should be located on your profile

## Continue Set Up
- Now that you have your api keys, run "EDITOR="code --wait" rails credentials:edit" insert all your information, then save and close the file

- Run "rails db:{drop, create, migrate}"

- Run "bundle exec rspec" (you should have 43 passing tests)

## Endpoints
- GET http://localhost:3000/api/v0/forecast?location=<LOCATION>

- POST http://localhost:3000/api/v0/users

- POST http://localhost:3000/api/v0/sessions

- POST http://localhost:3000/api/v0/road_trip