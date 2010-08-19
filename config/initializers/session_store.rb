# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scrum_session',
  :secret      => '6a556a0bf38a5d4c55b477b0d8269993cc591bcd70d4c9609a35fe1c15ae23bf0980ed68b28e5fe0875c66ae2922b82f93fd46d1e92c3ed1e8e3f856f66da9e1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
