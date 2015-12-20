#!/usr/bin/env ruby

require 'pp'
require '../lib/sfp/eeprom.rb'
require '../lib/sfp/rw.rb'

if ARGV.length != 1 || ARGV[0].length != 8
  puts 'Usage:'
  puts ' unlock.rb [password]'
  puts '  data: 4byte hexstring(ex: 00010203)'
  exit -1
end


password = ARGV[0].chomp
pass_hex = [password].pack("H*")

rw = SFP::RW.new
rw.write_password(pass_hex)
