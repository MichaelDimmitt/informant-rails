# Overview

## Informant Rails

The informant-rails gem provides Rails and ActiveRecord hooks for The Informant.

[![Homepage](https://s3.amazonaws.com/assets.heroku.com/addons.heroku.com/icons/1347/original.png)](https://addons.heroku.com/informant)

## Compatibility

The informant-rails gem supports the following versions of Ruby:
- 1.9.x
- 2.x
- rubinius
- jruby

It will work automatically with Rails 3.x / 4.x and Mongoid 3.x / 4.x.

[![Build Status](https://travis-ci.org/informantapp/informant-rails.svg?branch=master)](https://travis-ci.org/informantapp/informant-rails)
[![Code Climate](https://codeclimate.com/github/informantapp/informant-rails.png)](https://codeclimate.com/github/informantapp/informant-rails)

## Installation

Provision the Heroku add-on through their interface. Then add the `informant-rails` gem to your `Gemfile`.

```
gem 'informant-rails', group: :production
```

## Usage

By default, any request that causes an ActiveRecord or Mongoid model to be validated will be tracked by the Informant once the gem is added to your project.

### Tracking Other Validations

If you have other objects that conform to the ActiveModel interface, you can include validation tracking in your class and it will just work.

```
class VeryActiveModel
  include InformantRails::ValidationTracking
end
```

## Configuration

Configuration options are specified in the `InformantRails::Config` module. Reasonable defaults are provided but you can override them as necessary by creating an initializer and passing a block to `configure`.

```
InformantRails::Config.configure do |config|
  config.api_token = ENV['INFORMANT_API_KEY']
  config.exclude_models = %w(UntrackedModel)
  config.filter_parameters.push *%w(password password_confirmation)
  config.value_tracking = true
end
```

### api_token

Default Value: `ENV['INFORMANT_API_KEY']`

Example Value: `dff67d9e61eaa8cf110b3d3f3238a671`

This should be set to the API key assigned to you when you provisioned your application. Heroku will automatically add this to your environment when you provision the addon. Otherwise, you can get this from the Informant web application.

### exclude_models

Default Value: `[]`

Example Value: `['Person', 'Employee']`

This allows you to exclude certain models from tracking. If you don't want them to be included, just list their class names as strings.

### filter_parameters

Default Value: `Rails.configuration.filter_parameters`

Example Value: `['password', 'password_confirmation']`

Any field names specified here will not be included in value tracking. Any sensitive information that you wouldn't want to include in your server log should be listed here as well.

### value_tracking

Default Value: `true`

Example Value: `false`

This will enable and disable tracking of values globally. If you turn this off, no field value information will be sent at all. This is useful if you have compliance or security concerns about the nature of your data.
