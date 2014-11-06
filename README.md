parasol
=======

CAPTURE THE FUTURE.

[![Build Status](https://travis-ci.org/mayth/parasol.svg?branch=master)](https://travis-ci.org/mayth/parasol)

# Requirements
* Ruby 2.1
* PostgreSQL 9.3
* Bundler

## Packages
On Ubuntu, you may need to install these packages to install required gems:

* build-essential
* ruby-dev
* libpq-dev

# Setup
1. Clone this repository.
2. Create database user (role) on PostgreSQL. The user name is `parasol` by default (it can be changed by modifying `database.yml`). Note that the user should be able to create databases (CREATEDB). If not, you must create databases by your hand.
3. Remove `config/initializers/default_settings.rb` temporally.
4. Run `rake db:create`
5. Check the database. There will be `parasol_{development,test}`. In addition, if you want to run this server in a production environment, you must create a database named `parasol_production`.
6. Run `rake db:migrate`
7. Run `git checkout config/initializers/default_settings.rb` to restore the file removed in step 3.
8. Run `rails s`. Enjoy!

# License
This program is licensed under the MIT License. See `LICENSE`.

# Copyright
Copyright (c) 2014 Mei Akizuru (mayth)

Twitter: [@maytheplic](https://twitter.com/maytheplic)
