#!/bin/sh
shopt -s expand_aliases
source ~/workspace/bitbar_plugin/.env

exec ruby -S -x "$0" "$@"

#!ruby
require 'net/http'
require 'json'
require 'uri'

api_key = ENV['WEATHER_API_KEY'] # api token
city = 'Tokyo' # your city name
url = URI.parse("http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=imperial&appid=#{api_key}")

# text
emoji_list = [ 'id_error',
               '::',
               ':zap:',
               ':droplet',
               ':umbrella',
               ':cloud:',
               ':snowflake:',
               ':foggy:',
               ':sunny:',
               ':cyclone:']

begin
  res_json = Net::HTTP.get(url)

  weather = JSON.parse(res_json)['weather']
  id = weather[0]['id']
  id = id / 100

  print emoji_list[id]
rescue
  print ':sob:' # print ':sob:' when network error occurs
end

