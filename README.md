# Multicraft-API-Ruby
Ruby client for Multicraft API

Multicraft is a Minecraft server management web application. It has an HTTP API, documented [here](http://www.multicraft.org/site/docs/api), along with a PHP client implementation. So here is a Ruby version of the client! I wrote it to use in Rails/Sinatra web applications to get server information.

## Requirements
 - Ruby

## Features
 - Supports all Multicraft API calls as of March 2017 
 - Command line testing interface via repl()

## Usage
There's some example testing code commented out at the bottom:
```ruby
# mc = MulticraftAPI.new('http://localhost/api.php', 'homepage', '4QHMwZg=m9Zzgc')
# mc.return_data = true # Unused at the moment
# mc.repl # Runs command line interface
```
The parameters used when creating a new MulticraftAPI class are:
 - the API endpoint
 - API user's username
 - API user's API key

Using repl() is a good way to test API calls interactively. Some changes will need to be made to this code, since it's not a true repl.

An example program may look like this
```ruby
require_relative 'MulticraftAPI'
mc = MulticraftAPI.new('http://localhost/api.php', 'homepage', '4QHMwZg=m9Zzgc')
puts mc.listUsers()
```

## Notes
This project is functional but a WIP and could use some minor changes.

Also note that the Multicraft API is disabled by default, so make sure the setting is enabled, a user has an API key, and any network configuration (port forwarding and the like) is done to expose the API endpoint.
