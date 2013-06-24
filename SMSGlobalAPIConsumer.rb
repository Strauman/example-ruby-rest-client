#!/usr/bin/env ruby
# SMS GLobal
# http://smsglobal.com

require "./SMSGlobalAPIWrapper.rb"
require 'optparse'
require 'json'

options = {}
OptionParser.new do |opts|
    opts.banner = "usage: #{$0} [OPTIONS] [ARG ...]"

    opts.on("-v", "--verbose") do |arg|
        options[:verbose] = arg
    end
    opts.on("-s", "--ssl") do |arg|
        options[:ssl] = arg
    end
end.parse!

verbose = options[:verbose]
ssl = options[:ssl]
key = ARGV[0]
secret = ARGV[1]

# Open the gate :)
protocol = "http"
apiHost = "api.smsglobal.com"
apiPort = 80
apiVersion = "v1"
extraData = ""
if ssl == true then
    protocol = "https"
    apiPort = 443
end

wrapper = SMSGlobalAPIWrapper.new(key, secret, protocol, apiHost, apiPort, apiVersion, extraData, verbose)

# Get Balance
begin
    puts "\nGetting Balance .."
    balanceData = wrapper.get("balance")
    balance = JSON.parse(balanceData)
    puts "Your balance is: #{balance['balance']}"
    puts "Country code: #{balance['countryCode']}"
    puts "Cost per SMS: #{balance['costPerSms']}"
    puts "Cost per MMS: #{balance['costPerMms']}"
    puts "SMS available: #{balance['smsAvailable']}"
    puts "MMS available: #{balance['mmsAvailable']}"
rescue
    puts "Error getting balance"
end

