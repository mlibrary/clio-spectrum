# Be sure to restart your server when you modify this file.

# 3/2014 - we're seeing a handful of ActionDispatch::Cookies::CookieOverflow
# errors in production.
# The session holds the full set of search params (all facet values), plus the
# previous_url.  Should we revert to ActiveRecord?  Or try file-store?

# 1/2015 - flip back to DB session store.
# the EDS integration code stores lots of data in the session,
# which gives CookieOverflow for just about any search. 
# Put us back to database-based session store.  This means complete 
# dependency on a healthy MySQL, and worrying about the size of the 
# sessions table (routines truncation).

# Clio::Application.config.session_store :cookie_store, key: '_clio_session'
Clio::Application.config.session_store :active_record_store, :key => '_clio_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
