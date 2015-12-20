#!/usr/bin/env ruby

require 'pp'
require '../lib/sfp/eeprom.rb'
require '../lib/sfp/rw.rb'

if ARGV.length != 1 || ARGV[0].length != 6
  puts 'Usage:'
  puts ' rewrite_oui.rb [vendor_code]'
  puts '  vendor_code: 0a0b0c'
  exit -1
end

oui_hexstr = ARGV[0].chomp
oui = [oui_hexstr].pack("H*").unpack("CCC")

if oui.nil?
  puts 'specified  vendor is not found on this script'
  exit -1
end

rw = SFP::RW.new

# read current data and show
current_data = rw.read(256)

puts 'current data: '
data = SFP::EEPROM.new(current_data[0,128])
pp data
puts
puts current_data.unpack("H*")[0]

data.vendor_oui = oui
data.update_cc

new_data = data.to_hexstr

# show new data
puts 'new data:'
pp data
puts
puts new_data

print 'continue? (y/n) :'
ans = STDIN.gets.chomp

if ans != 'y'
  puts 'cancelled...'
  exit -2
end

#write
rw.write(data.to_hex)

# read wrote data and show
wrote_data = rw.read(256)

puts 'wrote data: '
data = SFP::EEPROM.new(wrote_data[0,128])
pp data
puts
puts wrote_data.unpack("H*")[0]

puts
puts 'Verification: ' + ((wrote_data[0,(new_data.length/2)] == [new_data].pack("H*")) ? "OK" : "Failed")
