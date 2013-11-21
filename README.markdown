# Overview

## Informant Rails

The informant-rails gem provides Rails and ActiveRecord hooks for The Informant.

[![Homepage](https://addons.heroku.com/informant)](https://addons.heroku.com.com/informant)

## Compatibility

The informant-rails gem is tested against Ruby 1.9.3, 2.0.0, and Rubinius.

[![Build Status](https://secure.travis-ci.org/theinformant/informant-rails.png)](http://travis-ci.org/informant/informant-rails)
[![Code Climate](https://codeclimate.com/github/theinformant/informant-rails.png)](https://codeclimate.com/github/informant/informant-rails)

## Installation

Provision the Heroku add-on through their interface. Then add the `informant-rails` gem to your `Gemfile`.

```
gem 'informant-rails', group: :production
```

## Usage

By default, any request that causes an ActiveRecord model to be validated will be tracked by the Informant once the gem is added to your project. If you have other objects that conform to the ActiveModel interface, you can cause them to be tracked by passing them to the Informant after their validations have run.

```
InformantRails::Client.inform(model)
```
