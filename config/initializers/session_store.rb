# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_chat_session',
  :secret      => '7ad97fd4da2dc06421476e4e0cc8349251b23161595b3cdb36e5c735cb7869c4d772029839e28d5a70e02230d1e555eade4b460e88bad11f9e04396f52ca4c14'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
