require 'grape'
require 'warden'
require 'pry'

class User

end

Warden::Strategies.add(:my_token) do
  def authenticate!
    if env['HTTP_AUTH_TOKEN'] == 'abc123'
      success!(User.new)
    else
      throw :warden
    end
  end
end


class MyAPI < Grape::API
  format :json
  use Warden::Manager do |manager|
    manager.default_strategies :my_token
    manager.failure_app = lambda {|env| [401,{}, ["Not authorized"]]}
  end

  resource :foo do
    get do
      { foo: 133 }
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
