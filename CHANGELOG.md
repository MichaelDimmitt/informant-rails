### 1.0.0 ###

* Long overdue major version bump
* Improved compatibility with older versions of rails
* Tracking your rails version to improve our support
* Change license to MIT

### 0.9.2 ###

* Prevent any initialization without an API key present

### 0.9.1 ###

* Change before_filter to before_action (Issue #3)

### 0.9.0 ###

* Support for Rails 5.0

### 0.8.0 ###

* Support for Rails 4.2

### 0.7.1 ###

* Make client identifier more easily accessible

### 0.7.0 ###

* Add a configuration option to completely disable field value tracking
* Replace typhoeus with Net::HTTP

### 0.6.0 ###

* Performance improvements
* Fixed a bug where a manually set API token may not be properly registered

### 0.5.0 ###

* Prevent initialization of hooks if API token is not present
* Add support for Mongoid
* Allow any ActiveModel object to take advantage of validation tracking

### 0.4.1 ###

* Require rake in informant-rails.rb

### 0.4.0 ###

* Add client identifier to payload
* Add rails 3.0 or higher requirement to gemspec
* Add rake task to verify connectivity
* Update API endpoint
