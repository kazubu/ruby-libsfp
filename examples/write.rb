#!/usr/bin/env ruby

require 'pp'
require '../lib/sfp/eeprom.rb'
require '../lib/sfp/rw.rb'

if ARGV.length != 1
  puts 'Usage:'
  puts ' write.rb [data]'
  puts '  data: hexstring(ex: 00112233445566778899aabbccddeeff...)'
  exit -1
end

new_data = ARGV[0].chomp

rw = SFP::RW.new

# read current data and show
current_data = rw.read(256)

puts 'current data: '
data = SFP::EEPROM.new(current_data[0,128])
pp data
puts
puts current_data.unpack("H*")[0]

# show new data
puts 'new data:'
data = SFP::EEPROM.new(new_data[0,256])
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
rw.write([new_data].pack("H*"))

# read wrote data and show
wrote_data = rw.read(256)

puts 'wrote data: '
data = SFP::EEPROM.new(wrote_data[0,128])
pp data
puts
puts wrote_data.unpack("H*")[0]

puts
puts 'Verification: ' + ((wrote_data[0,(new_data.length/2)] == [new_data].pack("H*")) ? "OK" : "Failed")
