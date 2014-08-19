This app is an example of using [Grape](https://github.com/intridea/grape) + [Warden](https://github.com/hassox/warden) authentication.
It defines a very simple API with two resources, foo and bar.
The former is public, whereas bar needs authentication.
 
In order to authenticate, API users provide a token called AUTH_TOKEN. For pedagogical reasons, the only valid token is 'abc123'.

The token can be provided as an HTTP Header, or as a query string parameter

## Instructions

1. Pull the repository 
` 
git clone git@github.com:geekazoid/grape-warden.git
`
2. Install dependencies
`
bundle install 
`
3. Start the server
`
rackup
`

## Usage

You can now access the resources using curl, for instance (or POSTMAN)

```
$ bundle exec rackup
[2014-08-19 17:02:08] INFO  WEBrick 1.3.1
[2014-08-19 17:02:08] INFO  ruby 2.1.2 (2014-05-08) [x86_64-linux]
[2014-08-19 17:02:08] INFO  WEBrick::HTTPServer#start: pid=22247 port=9292

$ curl http://localhost:9292/foo
{"foo":13}

$ curl http://localhost:9292/bar
Not authorized

# Authenticate using HTTP Header token
$ curl -H "AUTH_TOKEN:abc123" http://localhost:9292/bar
{"bar":666}

# Authenticate using query string
$ curl http://localhost:9292/bar?AUTH_TOKEN=abc123
{"bar":666} 
```
