#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'uri'

api_key = 'YOUR_API_KEY'
city = 'Tokyo'
url = URI.parse("http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=imperial&appid=#{api_key}")

# text
emoji_list = [ ':sob:',
               '::',
               ':zap:',
               ':droplet',
               ':umbrella',
               ':cloud:',
               ':snowflake:',
               ':foggy:',
               ':sunny:',
               ':cyclone:']

res_json = Net::HTTP.get(url)

weather = JSON.parse(res_json)['weather']
id = weather[0]['id']
id = id / 100

print emoji_list[id]

