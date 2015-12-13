require '../eeprom'
include SFP

def sample_finisar(_sfp)
  _sfp.identifier = IDENTIFIER::SFP
  _sfp.ext_identifier = 0x04
  _sfp.connector = SFP::CONNECTOR::LC
  _sfp.transciever = TRANSCIEVER::GE_SX | TRANSCIEVER::FC_LINK_I | TRANSCIEVER::FC_TXT_SN | TRANSCIEVER::FC_TXM_M6 | TRANSCIEVER::FC_TXM_M5 | TRANSCIEVER::FC_SPEED_200M | TRANSCIEVER::FC_SPEED_100M
  _sfp.encoding = ENCODING::ENC_8B10B
  _sfp.br = BR::BR_2125M
  _sfp.length_sm_km = 0
  _sfp.length_sm_100m = 0
  _sfp.length_mm500_10m = 30
  _sfp.length_mm625_10m = 15
  _sfp.length_copper = 0
  _sfp.vendor_name = "FINISAR CORP."
  _sfp.vendor_oui = [0x00, 0x90, 0x65]
  _sfp.vendor_pn = "FTRJ8519P1BNL-J2"
  _sfp.vendor_rev = "A"
  _sfp.wavelength = 850
  _sfp.options = OPTIONS::TX_DISABLE | OPTIONS::LOSS_OF_SIGNAL
  _sfp.br_max = 0x00
  _sfp.br_min = 0x00
  _sfp.vendor_sn = "P8N1UF0"
  _sfp.date_code = "051125"
  _sfp.diagnostic_monitoring_type = 0x58
  _sfp.enhanced_options = ENHANCED_OPTIONS::ALARM_WARN_FLAG | ENHANCED_OPTIONS::SOFT_RX_LOS
  _sfp.sff_8472_compliance = 0x01
  _sfp.vendor_specific = "740-011782 REV 01"
end

def sample_finisar_2(_sfp)
  _sfp.identifier = :SFP
  _sfp.ext_identifier = 0x04
  _sfp.connector = :LC
  _sfp.transciever = [:GE_SX , :FC_LINK_I , :FC_TXT_SN , :FC_TXM_M6 , :FC_TXM_M5 , :FC_SPEED_200M , :FC_SPEED_100M]
  _sfp.encoding = :ENC_8B10B
  _sfp.br = :BR_2125M
  _sfp.length_sm_km = 0
  _sfp.length_sm_100m = 0
  _sfp.length_mm500_10m = 30
  _sfp.length_mm625_10m = 15
  _sfp.length_copper = 0
  _sfp.vendor_name = "FINISAR CORP."
  _sfp.vendor_oui = [0x00, 0x90, 0x65]
  _sfp.vendor_pn = "FTRJ8519P1BNL-J2"
  _sfp.vendor_rev = "A"
  _sfp.wavelength = 850
  _sfp.options = [ :TX_DISABLE , :LOSS_OF_SIGNAL ]
  _sfp.br_max = 0x00
  _sfp.br_min = 0x00
  _sfp.vendor_sn = "P8N1UF0"
  _sfp.date_code = "051125"
  _sfp.diagnostic_monitoring_type = 0x58
  _sfp.enhanced_options = [ :ALARM_WARN_FLAG, :SOFT_RX_LOS ]
  _sfp.sff_8472_compliance = 0x01
  _sfp.vendor_specific = "740-011782 REV 01"
end



def sample_qstar(_sfp)
  _sfp.identifier = IDENTIFIER::SFP
  _sfp.ext_identifier = 0x04
  _sfp.connector = SFP::CONNECTOR::LC
  _sfp.transciever = TRANSCIEVER::GE_LX | TRANSCIEVER::FC_LINK_V | TRANSCIEVER::FC_TXT_LC | TRANSCIEVER::FC_TXM_SM
  _sfp.transciever = 0x0000000282000100
  _sfp.encoding = ENCODING::ENC_8B10B
  _sfp.br = BR::BR_1250M
  _sfp.length_sm_km = 20
  _sfp.length_sm_100m = 0
  _sfp.length_mm500_10m = 0
  _sfp.length_mm625_10m = 0
  _sfp.length_copper = 0
  _sfp.vendor_name = "Q-STAR"
  _sfp.vendor_oui = [0x00, 0x00, 0x00]
  _sfp.vendor_pn = "BYCL-442C3"
  _sfp.vendor_rev = "SB"
  _sfp.wavelength = 1550
  _sfp.options = OPTIONS::TX_DISABLE | OPTIONS::TX_FAULT | OPTIONS::LOSS_OF_SIGNAL
  _sfp.br_max = 0x05
  _sfp.br_min = 0x05
  _sfp.vendor_sn = "W1204162310001"
  _sfp.date_code = "120419"
  _sfp.diagnostic_monitoring_type = 0x00
  _sfp.enhanced_options = 0x00
  _sfp.sff_8472_compliance = 0x00
  _sfp.vendor_specific = ""
end



sfp = SFP::EEPROM.new
puts "test 1 fail" if sfp.to_hexstr != "0000000000000000000000000000000000000000202020202020202020202020202020200000000020202020202020202020202020202020202020200000008000000000202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000"

sample_finisar(sfp)

puts "test 2 fail" if sfp.to_hexstr != "0304070000000120400c0501150000001e0f000046494e4953415220434f52502e202020000090654654524a383531395031424e4c2d4a3241202020035200af0012000050384e3155463020202020202020202030353131323520205890015b3734302d30313137383220524556203031000000000000000000000000000000"

sample_finisar_2(sfp)

puts "test 3 fail" if sfp.to_hexstr != "0304070000000120400c0501150000001e0f000046494e4953415220434f52502e202020000090654654524a383531395031424e4c2d4a3241202020035200af0012000050384e3155463020202020202020202030353131323520205890015b3734302d30313137383220524556203031000000000000000000000000000000"

sample_qstar(sfp)

puts "test 4 fail" if sfp.to_hexstr != "0304070000000282000100010d00140000000000512d5354415220202020202020202020000000004259434c2d343432433320202020202053422020060e00bd001a0505573132303431363233313030303120203132303431392020000000b10000000000000000000000000000000000000000000000000000000000000000"

