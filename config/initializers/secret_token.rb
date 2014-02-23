# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Parasol::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || 'a075f1bd4ff9bb3996b0e53236830d778e86f07e679dc9e6d50e9921fb701c4c58003f50e6878400c3accc321f9615ff24606dd303d9345943862ac0caca1e7f'
