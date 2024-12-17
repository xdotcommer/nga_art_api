require 'bundler'
require 'grape'
require 'grape-entity'
require 'grape-swagger'
require 'grape-swagger-entity'
require_relative 'app'
require_relative 'api/base'

Bundler.require

use Rack::Session::Cookie
run Rack::Cascade.new [App, API::Base]
