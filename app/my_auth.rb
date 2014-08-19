require 'warden'

class User

end

Warden::Strategies.add(:my_token) do
  def authenticate!
    token = env['HTTP_AUTH_TOKEN'] || env['rack.request.query_hash']['AUTH_TOKEN']
    if token == 'abc123'
      success!(User.new)
    else
      throw :warden
    end
  end
end
