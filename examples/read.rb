#!/usr/bin/env ruby

require 'pp'
require '../lib/sfp/eeprom.rb'
require '../lib/sfp/rw.rb'

rw = SFP::RW.new

raw_data = rw.read(256)

puts 'raw data: '
puts raw_data.unpack("H*")[0]

data = SFP::EEPROM.new(raw_data[0,128])
puts
pp data

puts 'Base CC is valid? : ' + data.validate_cc_base.to_s
puts 'Ext CC is valid? : ' + data.validate_cc_ext.to_s

data.update_cc
puts 'Expected Base CC: ' + data.cc_base.to_s
puts 'Expected Ext CC: ' + data.cc_ext.to_s

