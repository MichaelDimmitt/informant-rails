# Overview

## Informant Rails

The informant-rails gem provides Rails and ActiveRecord hooks for The Informant.

[![Homepage](https://s3.amazonaws.com/assets.heroku.com/addons.heroku.com/icons/1347/original.png)](https://addons.heroku.com/informant)

## Compatibility

The informant-rails gem is tested against Ruby 1.9.3, 2.0.0, and Rubinius.

[![Build Status](https://travis-ci.org/informantapp/informant-rails.svg?branch=master)](https://travis-ci.org/informantapp/informant-rails)
[![Code Climate](https://codeclimate.com/github/informantapp/informant-rails.png)](https://codeclimate.com/github/informantapp/informant-rails)

## Installation

Provision the Heroku add-on through their interface. Then add the `informant-rails` gem to your `Gemfile`.

```
gem 'informant-rails', group: :production
```

## Usage

By default, any request that causes an ActiveRecord model to be validated will be tracked by the Informant once the gem is added to your project.
