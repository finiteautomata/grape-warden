# This app is an example of using Grape + Warden authentication
# It defines a very simple API with two resources, foo and bar. 
# The former is public, whereas bar needs authentication.
# 
# In order to authenticate, API users provide a token called AUTH_TOKEN. For pedagogical reasons, the only valid token is 'abc123'.
# The token can be provided as an HTTP Header, or as a query string parameter


require_relative 'my_auth'

require 'grape'
require 'warden'
require 'pry'

class MyAPI < Grape::API
  format :json
  use Warden::Manager do |manager|
    manager.default_strategies :my_token
    manager.failure_app = lambda {|env| [401,{}, ["Not authorized"]]}
  end

  resource :foo do
    get do
      { foo: 13 }
    end
  end

  resource :bar do
    before do
      env['warden'].authenticate :my_token
    end
    get do
      { bar: 666 }
    end
  end
end
