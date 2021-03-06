source 'https://rubygems.org' do

  gem 'skylight'
  gem 'net-ldap'
  gem 'twilio-ruby'
  gem 'exlibris-aleph', '~>2.0.4'
  gem 'puma'

  gem 'ipresolver',
    git: 'https://github.com/mlibrary/ipresolver',
    branch: 'master'

  gem 'keycard',
    git: 'https://github.com/bertrama/keycard',
    branch: 'rack-yaml-institution-finder',
    require: ['keycard/rack', 'keycard/yaml/institution_finder']

  gem 'nodenv-wrapper',
    git: 'https://github.com/mlibrary/nodenv-wrapper',
    branch: 'master'

  gem 'spectrum-config',
    git: 'https://github.com/mlibrary/spectrum-config',
    branch: 'master'

  gem 'spectrum-json',
    git: 'https://github.com/mlibrary/spectrum-json',
    branch: 'master'

  gem 'aleph',
    git: 'https://github.com/mlibrary/aleph',
    branch: 'master'
  
  gem 'rails', '~> 4.2.0'

  #  ###  BLACKLIGHT (begin)  ###
  gem 'blacklight', '~>5.3.0'
  gem 'blacklight-marc'


  #  ###  BLACKLIGHT (end)  ###

  # A recent Kaminari update broke blacklight facet pagination.
  # https://github.com/amatsuda/kaminari/commit/5e2e505cdd2ea2de20949d5cef261c247b3168b1
  # This isn't fixed in Blacklight until 5.5.0,
  # so pin kaminari to a pre-breakage release
  gem 'kaminari', '0.15.0'
  gem 'json'

  platforms :mri do
    gem 'therubyracer'
  end

  gem 'httpclient'
  gem 'nokogiri', '1.6.1'

  # HTML replacement language
  gem 'haml'
  gem 'haml-rails'

  # CSS replacement language
  gem 'sass'

  gem 'unicode'
  gem 'summon'
  gem 'cancan'
  gem 'exception_notification'

  # "Rack middleware which cleans up invalid UTF8 characters"
  # gem 'rack-utf8_sanitizer'
  # Use github master branch, to pick up a few new patches.
  # Maybe this will fix one of our outstanding issues:
  #    application#catch_404s (ArgumentError) "invalid %-encoding"
  # We also still have invalid %-encoding w/submitted form fields.
  # This is an open issue at rack-utf8_sanitizer.
  # gem 'rack-utf8_sanitizer', :github => 'whitequark/rack-utf8_sanitizer'
  gem 'rack-utf8_sanitizer', :git => 'https://github.com/whitequark/rack-utf8_sanitizer'

  # gives us jQuery and jQuery-ujs, but not jQuery UI
  # (blacklight_range_limit brings this in anyway - no way to switch to CDN)
  gem 'jquery-rails'
  
  group :assets do
    gem 'sass-rails'
    gem 'coffee-rails'
    gem 'uglifier'
    gem 'bootstrap-sass'
  end


  # To build slugs for saved-list URLs
  gem 'stringex'

  group :development do
    gem 'rbtrace'
    gem 'pry'
    gem 'pry-byebug', platforms: :mri
    gem 'pry-rails'
    gem 'rerun'
    gem 'quiet_assets'

    platforms :mri do
      # browser-based live debugger and REPL
      # http://railscasts.com/episodes/402-better-errors-railspanel
      gem 'better_errors'
      gem 'binding_of_caller'
  
      # "A fist full of code metrics"
      gem 'metric_fu'
    end

    # Profiling experiments
    # https://www.coffeepowered.net/2013/08/02/ruby-prof-for-rails/
    # gem 'request_profiler', :git => "git://github.com/justinweiss/request_profiler.git"

  end

  group :test, :development do
    gem 'rspec-rails'
  end

  group :test do
    gem 'minitest'

    gem 'factory_girl_rails'

    # Copy Stanford's approach to Solr relevancy testing
    gem 'rspec-solr'

    # pin to old version, or go with newest?
    gem 'capybara'

    # Which Capybara driver for JS support?
    platforms :mri do
      gem 'ruby-prof'
    end
    # dependent on localhost's browser configs

    gem 'launchy'
    gem 'database_cleaner'

    gem 'rb-fsevent'

    # code coverage
    gem 'simplecov'

  end
end
