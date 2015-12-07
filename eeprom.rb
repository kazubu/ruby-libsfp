module SFP
  module IDENTIFIER
    UNKNOWN = 0
    GBIC = 1
    SOLDERED = 2
    SFP = 3
  end

  module CONNECTOR
    UNKNOWN = 0
    SC = 1
    LC = 7
    MTRJ = 8
    MU = 9
  end

  module TRANSCIEVER
    XGE_ER = 1<<63
    XGE_LRM = 1<<62
    XGE_LR = 1<<61
    XGE_SR = 1<<60
    IB_1X_SX = 1<<59
    IB_1X_LX = 1<<58
    IB_1X_CA = 1<<57
    IB_1X_CP = 1<<56
    ESCON_MMF = 1<<55
    ESCON_SMF = 1<<54
    OC192_SR = 1<<53
    SONET_RS1 = 1<<52
    SONET_RS2 = 1<<51
    OC48_LR = 1<<50
    OC48_IR = 1<<49
    OC48_SR = 1<<48
    OC12_SM_LR = 1<<46
    OC12_SM_IR = 1<<45
    OC12_SR = 1<<44
    OC3_SM_LR = 1<<42
    OC3_SM_IR = 1<<41
    OC3_SR = 1<<40

    PX = 1<<39
    BX10 = 1<<38
    FE_FX = 1<<37
    FE_LX = 1<<36
    GE_T = 1<<35
    GE_CX = 1<<34
    GE_LX = 1<<33
    GE_SX = 1<<32

    FC_LINK_V = 1<<31
    FC_LINK_S = 1<<30
    FC_LINK_I = 1<<29
    FC_LINK_L = 1<<28
    FC_LINK_M = 1<<27
    FC_TXT_SA = 1<<26
    FC_TXT_LC = 1<<25
    FC_TXT_EL = 1<<24
    FC_TXT_EL2 = 1<<23
    FC_TXT_SN = 1<<22
    FC_TXT_SL = 1<<21
    FC_TXT_LL = 1<<20

    FC_TXM_TW = 1<<15
    FC_TXM_TP = 1<<14
    FC_TXM_MI = 1<<13
    FC_TXM_TV = 1<<12
    FC_TXM_M6 = 1<<11
    FC_TXM_M5 = 1<<10
    FC_TXM_SM = 1<<8

    FC_SPEED_1200M = 1<<7
    FC_SPEED_800M = 1<<6
    FC_SPEED_1600M = 1<<5
    FC_SPEED_400M = 1<<4
    FC_SPEED_200M = 1<<2
    FC_SPEED_100M = 1
  end

  module ENCODING
    ENC_8B10B = 1
    ENC_4B5B = 2
    ENC_NRZ = 3
    ENC_MANCHESTER = 4
  end

  module BR
    BR_1250M = 0x0d
    BR_2125M = 0x15
  end

  module OPTIONS
    RATE_SELECT = 0x20
    TX_DISABLE = 0x10
    TX_FAULT = 0x08
    LOSS_OF_SIGNAL_INVERTED = 0x04
    LOSS_OF_SIGNAL = 0x02
  end

  module DIAGNOSTIC_MONITORING_TYPE
    RESERVED_FOR_LEGACY = 0x80
    DDM = 0x40
    INTERNAL_CALIBRATED = 0x20
    EXTERNAL_CALIBRATED = 0x10
    RECEIVED_POWER_MEASUREMENT_AVERAGE = 0x08
    ADDRESS_CHANGE_REQUIRED = 0x04
  end

  module ENHANCED_OPTIONS
    ALARM_WARN_FLAG = 0x80
    SOFT_TX_DISABLE = 0x40
    SOFT_TX_FAULT = 0x20
    SOFT_RX_LOS = 0x10
    SOFT_RATE_SELECT = 0x08
    APPLICATION_SELECT_CONTROL = 0x04
    SOFT_RATE_SELECT_8431 = 0x02
  end

  class EEPROM

    attr_accessor :identifier, :ext_identifier, :connector, :transciever, :encoding, :br, :length_sm_km, :length_sm_100m, :length_mm500_10m, :length_mm625_10m, :length_copper, :vendor_name, :vendor_oui, :vendor_pn, :vendor_rev, :wavelength, :options, :br_max, :br_min, :vendor_sn, :date_code, :diagnostic_monitoring_type, :enhanced_options, :sff_8472_compliance, :vendor_specific

    def to_hex
      base = [@identifier, @ext_identifier, @connector, @transciever>>32, @transciever, @encoding, @br, 0, @length_sm_km, @length_sm_100m, @length_mm500_10m, @length_mm625_10m, @length_copper, 0, @vendor_name, 0, @vendor_oui.pack('C3'), @vendor_pn, @vendor_rev, @wavelength, 0].pack("CCCNNCCCCCCCCCA16Ca3A16A4nC")

      c = 0
      base.each_byte{|b| c += b}
      base+= [c.to_s(16)[-2,2]].pack("H2")

      ext = [@options, @br_max, @br_min, @vendor_sn, @date_code, @diagnostic_monitoring_type, @enhanced_options, @sff_8472_compliance].pack("nCCA16A8CCC")
      c = 0
      ext.each_byte{|b| c += b}
      ext+= [c.to_s(16)[-2,2]].pack("H2")

      vendor_specific = [@vendor_specific].pack("a32")

      return base+ext+vendor_specific
    end

    def to_hexstr
      return to_hex.unpack("H*")[0]
    end

    def initialize(str=nil)
      @identifier = 0
      @ext_identifier = 0
      @connector = 0
      @transciever = 0
      @encoding = 0
      @br = 0
      @length_sm_km = 0
      @length_sm_100m = 0
      @length_mm500_10m = 0
      @length_mm625_10m = 0
      @length_copper = 0
      @vendor_name = ""
      @vendor_oui = [0x00, 0x00, 0x00]
      @vendor_pn = ""
      @vendor_rev = ""
      @wavelength = 0
      @options = 0
      @br_max = 0x00
      @br_min = 0x00
      @vendor_sn = ""
      @date_code = ""
      @diagnostic_monitoring_type = 0
      @enhanced_options = 0
      @sff_8472_compliance = 0
      @vendor_specific = ""

      if !str.nil? && str.length == 256
        parse_hexstr(str)
      else
        return
      end
    end

    def parse_hexstr(str)
      return false if str.length != 256
      tr_1 = nil
      tr_2 = nil
      oui = nil
      @identifier, @ext_identifier, @connector, tr_1, tr_2, @encoding, @br, a, @length_sm_km, @length_sm_100m, @length_mm500_10m, @length_mm625_10m, @length_copper,a, @vendor_name,a, oui, @vendor_pn, @vendor_rev, @wavelength,a,a,@options, @br_max, @br_min, @vendor_sn, @date_code, @diagnostic_monitoring_type, @enhanced_options, @sff_8472_compliance, a, @vendor_specific = [str].pack("H*").unpack("CCCNNCCCCCCCCCA16Ca3A16A4nCCnCCA16A8CCCCa*")
      @transciever = (tr_1<<32) + tr_2
      @vendor_oui = oui.unpack('C3')
    end

    def sample_finisar
      @identifier = IDENTIFIER::SFP
      @ext_identifier = 0x04
      @connector = SFP::CONNECTOR::LC
      @transciever = TRANSCIEVER::GE_SX | TRANSCIEVER::FC_LINK_I | TRANSCIEVER::FC_TXT_SN | TRANSCIEVER::FC_TXM_M6 | TRANSCIEVER::FC_TXM_M5 | TRANSCIEVER::FC_SPEED_200M | TRANSCIEVER::FC_SPEED_100M
      @encoding = ENCODING::ENC_8B10B
      @br = BR::BR_2125M
      @length_sm_km = 0
      @length_sm_100m = 0
      @length_mm500_10m = 30
      @length_mm625_10m = 15
      @length_copper = 0
      @vendor_name = "FINISAR CORP."
      @vendor_oui = [0x00, 0x90, 0x65]
      @vendor_pn = "FTRJ8519P1BNL-J2"
      @vendor_rev = "A"
      @wavelength = 850
      @options = OPTIONS::TX_DISABLE | OPTIONS::LOSS_OF_SIGNAL
      @br_max = 0x00
      @br_min = 0x00
      @vendor_sn = "P8N1UF0"
      @date_code = "051125"
      @diagnostic_monitoring_type = 0x58
      @enhanced_options = ENHANCED_OPTIONS::ALARM_WARN_FLAG | ENHANCED_OPTIONS::SOFT_RX_LOS
      @sff_8472_compliance = 0x01
      @vendor_specific = "740-011782 REV 01"
    end

    def sample_qstar
      @identifier = IDENTIFIER::SFP
      @ext_identifier = 0x04
      @connector = SFP::CONNECTOR::LC
      @transciever = TRANSCIEVER::GE_LX | TRANSCIEVER::FC_LINK_V | TRANSCIEVER::FC_TXT_LC | TRANSCIEVER::FC_TXM_SM
      @transciever = 0x0000000282000100
      @encoding = ENCODING::ENC_8B10B
      @br = BR::BR_1250M
      @length_sm_km = 20
      @length_sm_100m = 0
      @length_mm500_10m = 0
      @length_mm625_10m = 0
      @length_copper = 0
      @vendor_name = "Q-STAR"
      @vendor_oui = [0x00, 0x00, 0x00]
      @vendor_pn = "BYCL-442C3"
      @vendor_rev = "SB"
      @wavelength = 1550
      @options = OPTIONS::TX_DISABLE | OPTIONS::TX_FAULT | OPTIONS::LOSS_OF_SIGNAL
      @br_max = 0x05
      @br_min = 0x05
      @vendor_sn = "W1204162310001"
      @date_code = "120419"
      @diagnostic_monitoring_type = 0x00
      @enhanced_options = 0x00
      @sff_8472_compliance = 0x00
      @vendor_specific = ""
    end
  end
end
