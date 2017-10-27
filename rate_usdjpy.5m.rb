#!/usr/bin/ruby

require 'net/http'
require 'uri'
require 'json'

url = URI.parse('https://www.gaitameonline.com/rateaj/getrate')

res_json = Net::HTTP.get(url)

# 'USDJPY' is #21 in this list of rates
rate_bid = JSON.parse(res_json)['quotes'][20]['bid']

print "USD JPY: #{rate_bid}"
