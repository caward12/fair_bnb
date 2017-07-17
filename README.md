# Fairbnb

![schema pic](app/assets/images/home.png?raw=true)

View it live at: https://fair-b-n-b.herokuapp.com/

Admin Analytics Dashboard build with Dimple.js and D3
![analtics pic](app/assets/images/fairbnb_analytics.gif)

## Overview

The goal of this project was to 'clone' the base functionality of Airbnb.

### Setup

To set up a local copy of this project, perform the following:

run `Bundle`

run `rake db:reset`

run `bundle exec figaro install` & add keys to `config/application.yml`:
```  
GOOGLE_CLIENT_ID: <KEY>
GOOGLE_CLIENT_SECRET: <SECRET_KEY>
FACEBOOK_KEY: <KEY>
FACEBOOK_SECRET: <SECRET_KEY>
GOOGLE_MAP_KEY: <KEY>
WEATHER_KEY: <KEY>
test:
  GOOGLE_USER_TOKEN:
  FACEBOOK_USER_TOKEN:
```
**Internal API**

The following api endpoints are available:

*For users*

`/api/v1/users/money/most_revenue` lists users who have made the most money as property owners based on reservation income. Can take a `limit` param, default is 10 users.

`/api/v1/users/money/most_spent` lists users who have spent the most money on reservations. Can take a `limit` param, default is 10.

`/api/v1/users/properties/most_properties` lists users who have the most properties listed that they are the owner of. Can take a `limit` param, default is 10.

`/api/v1/users/reservations/bookings` lists users who have made the most reservations. Can take a `limit` param, default is 10.

`/api/v1/users/reservations/nights` lists users who have booked the most number of nights. Can take a `limit` param, default is 10.

*For reservations*

`/api/v1/reservations/by_month` lists count of reservations by month. Can take a `city` param, that scopes to reservations by month for that city, default is for all reservations.

### Design
* We used [Bootstrap](http://getbootstrap.com/) to style our website.

### Test Suite

* The test suite tests the application on multiple levels. To run all of the tests, run `rspec` from the terminal in the main directory of the project. The feature tests (integration tests) rely mainly on the [capybara gem](https://github.com/jnicklas/capybara) for navigating the various application views.

### Dependencies

* This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project.

#### **Sending email**

##### Redis:

`$ redis-server`

if you don’t already have redis, install it with homebrew:

`$ brew update && brew install redis`

Then run `redis-server.`

##### Before pushing to heroku:

run:
'$ heroku addons:create heroku-redis:hobby-dev -a app_name'

add to cable.yml file

`production:`
  `adapter: redis`
  `url: redis://h:p97f4ddb2aacd4224b4efb3eac4626d36a8f4223fbb0b100f7c6a48c008ca3328@ec2-34-195-166-91.compute-1.amazonaws.com:29559`

  Article [Heroku Redis](https://devcenter.heroku.com/articles/heroku-redis)

### Contributors

[Brett Schwartz](https://github.com/bschwartz10)  
[Colleen Ward](https://github.com/caward12)  
[Sam Landfried](https://github.com/samlandfried)  
[Sergey Lukyanenko](https://github.com/lukyans)  
