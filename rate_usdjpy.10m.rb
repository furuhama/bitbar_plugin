#!/usr/bin/ruby

require 'net/http'
require 'uri'
require 'json'

url = URI.parse('https://www.gaitameonline.com/rateaj/getrate')

res_json = Net::HTTP.get(url)

begin
  # 'USDJPY' is #21 in list of rates
  # get 'bid' rate
  rate_bid = JSON.parse(res_json)['quotes'][20]['bid']

  print "#{rate_bid}"
rescue
  # for network error
  print ':money_with_wings:'
end

