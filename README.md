parasol
=======

CAPTURE THE FUTURE.

[![Circle CI](https://circleci.com/gh/mayth/parasol.svg?style=shield)](https://circleci.com/gh/mayth/parasol)
[![Test Coverage](https://codeclimate.com/github/mayth/parasol/badges/coverage.svg)](https://codeclimate.com/github/mayth/parasol/coverage)
[![Code Climate](https://codeclimate.com/github/mayth/parasol/badges/gpa.svg)](https://codeclimate.com/github/mayth/parasol)
[![Dependency Status](https://gemnasium.com/mayth/parasol.svg)](https://gemnasium.com/mayth/parasol)

# About

**parasol** is a score server application for "Capture the Flag" (CTF) contest made with [Ruby on Rails](http://rubyonrails.org/).

# Requirements
* Ruby 2.1
* PostgreSQL 9.3
* Bundler

## Packages
On Ubuntu, you may need to install these packages to install required gems:

* build-essential
* ruby-dev
* libpq-dev

On CentOS? Sorry, I have no idea...

# Setup
1. Clone this repository.
2. Create an user on PostgreSQL. The user name is `parasol` by default (it can be changed by modifying `database.yml`). Note that the user should be able to create databases. If not, you must create databases by your hand.
3. Run `rake db:create`
4. Check the database. There will be `parasol_{development,test,production}`. The name of database depends on the environment variable `RAILS_ENV`.
5. Run `rake db:migrate`
6. Run `rails s`. Enjoy!

## Admin

There is no admin accounts after the setup completed. To add an admin user:

```
bin/rake admin:create_user EMAIL='email@address.here' PASSWORD='passw0rd_here'
```

After the admin account created, you can sign in as an admin from `/admin`.

## Notes

For production use, you should set the environment variable `RAILS_ENV` to `production` and use `foreman start` to start the server instead of `rails s`.

# Remarks

## Flag Matching

parasol uses Regexp to compare the submitted flag and the answer. So, be careful when you set the flag word which contains `?`, `*`, and any other regexp's metacharacters.

## Scoring

### Flag point modification affects scores of already answered players

parasol calculates the score when it is requested. It means that *the player's score will be changed when the flag's point is changed*.

For example,

1. Player A submits the correct flag for challenge X (100pts.)
2. A's score is changed to 100 pts.
3. The admin changed the point for X to 200 pts.
4. A's score is changed to 200 pts.

### First-break Point and Point Modification

The first-break point (a.k.a. first-blood point) feature is implemented as "score adjustment". If it is enabled, the adjustment point is calculated when the player solves the problem, and *it is fixed*. Modification of the flag's point will **not** affect to  the first-break point. If you want to fix it, you should do it by your hand.

# License
This program is licensed under the MIT License. See `LICENSE`.

# Copyright
Copyright (c) 2014 Mei Akizuru (mayth)

Twitter: [@maytheplic](https://twitter.com/maytheplic)
