module SFP
  module IDENTIFIER
    UNKNOWN = 0x00
    GBIC = 0x01
    SOLDERED = 0x02
    SFP = 0x03
    XBI_300 = 0x04
    XENPAK = 0x05
    XFP = 0x06
    XFF = 0x07
    XFP_E = 0x08
    XPAK = 0x09
    X2 = 0x0A
    DWDM_SFP = 0x0B
    QSFP = 0x0C
    QSFPP = 0x0D
    CXP = 0x0E
  end

  module CONNECTOR
    UNKNOWN = 0x00
    SC = 0x01
    FC_1_COPPER = 0x02
    FC_2_COPPER = 0x03
    BNC_TNC = 0x04
    FC_COAX_HEADERS = 0x05
    FIBERJACK = 0x06
    LC = 0x07
    MTRJ = 0x08
    MU = 0x09
    SG = 0x0A
    OPTICAL_PIGTAIL = 0x0B
    MPO = 0x0C
    HSSDC_II = 0x20
    COPPER_PIGTAIL = 0x21
    RJ45 = 0x22
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
    ENC_SONET_SCRAMBLED = 5
    ENC_64B66B = 6
  end

  module BR
    BR_1250M = 0x0d
    BR_2125M = 0x15
  end

  module RATE_IDENTIFIER
    SFF_8079 = 0x01
    SFF_8431_8_4_2_RX_ONLY  = 0x02
    SFF_8431_8_4_2_TX_ONLY  = 0x04
    SFF_8431_8_4_2_INDEPENDENT = 0x06
    FC_PI_5_16_8_4_RX_ONLY = 0x08
    FC_PI_5_16_8_4_INDEPENDENT = 0x0a
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

    def initialize(str=nil)
      @identifier = 0
      @ext_identifier = 0
      @connector = 0
      @transciever = []
      @encoding = 0
      @br = 0
      @rate_identifier = 0
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
      elsif !str.nil? && str.length == 128
        parse_hex(str)
      else
        return
      end
    end

    def syms_to_val(mod, syms)
      syms = [syms] if syms.class != Array
      ret = 0

      syms.each{|sym|
        ret |= mod.const_get(sym.to_s)
      }

      return ret
    end

    def val_to_sym(mod, val)
      mod.constants.each{|sym|
        if val == mod.const_get(sym.to_s)
          return sym
        end
      }
      return val
    end

    def val_to_syms(mod, val)
      ret = []
      mod.constants.each{|sym|
        ret << sym if val & mod.const_get(sym.to_s) != 0
      }

      # return original value if value contains unsupported something
      return val if syms_to_val(mod, ret) != val

      return ret
    end

    def to_hex
      identifier = @identifier.class == Fixnum ? @identifier : syms_to_val(IDENTIFIER, @identifier)
      connector = @connector.class == Fixnum ? @connector : syms_to_val(CONNECTOR, @connector)
      transciever = (@transciever.class == Fixnum || @transciever.class == Bignum) ? @transciever : syms_to_val(TRANSCIEVER, @transciever)
      encoding = @encoding.class == Fixnum ? @encoding : syms_to_val(ENCODING, @encoding)
      br = @br.class == Fixnum ? @br : syms_to_val(BR, @br)
      rate_identifier = @rate_identifier.class == Fixnum ? @rate_identifier : syms_to_val(RATE_IDENTIFIER, @rate_identifier)
      options = @options.class == Fixnum ? @options : syms_to_val(OPTIONS, @options)
      diagnostic_monitoring_type = @diagnostic_monitoring_type.class == Fixnum ? @diagnostic_monitoring_type : syms_to_val(DIAGNOSTIC_MONITORING_TYPE, @diagnostic_monitoring_type)
      enhanced_options = @enhanced_options.class == Fixnum ? @enhanced_options : syms_to_val(ENHANCED_OPTIONS, @enhanced_options)

      base = [identifier, @ext_identifier, connector, transciever>>32, transciever, encoding, br, rate_identifier, @length_sm_km, @length_sm_100m, @length_mm500_10m, @length_mm625_10m, @length_copper, 0, @vendor_name, 0, @vendor_oui.pack('C3'), @vendor_pn, @vendor_rev, @wavelength, 0].pack("CCCNNCCCCCCCCCA16Ca3A16A4nC")

      c = 0
      base.each_byte{|b| c += b}
      base+= [(c%256).to_s(16)].pack("H2")

      ext = [options, @br_max, @br_min, @vendor_sn, @date_code, diagnostic_monitoring_type, enhanced_options, @sff_8472_compliance].pack("nCCA16A8CCC")
      c = 0
      ext.each_byte{|b| c += b}
      ext+= [(c%256).to_s(16)].pack("H2")

      vendor_specific = [@vendor_specific].pack("a32")

      return base+ext+vendor_specific
    end

    def parse_hex(str)
      return false if str.length != 128
      tr_1 = nil
      tr_2 = nil
      oui = nil
      identifier, @ext_identifier, connector, tr_1, tr_2, encoding, br, rate_identifier, @length_sm_km, @length_sm_100m, @length_mm500_10m, @length_mm625_10m, @length_copper,a, @vendor_name,a, oui, @vendor_pn, @vendor_rev, @wavelength,a,a,options, @br_max, @br_min, @vendor_sn, @date_code, diagnostic_monitoring_type, enhanced_options, @sff_8472_compliance, a, @vendor_specific = str.unpack("CCCNNCCCCCCCCCA16Ca3A16A4nCCnCCA16A8CCCCa*")
      transciever = (tr_1<<32) + tr_2
      @vendor_oui = oui.unpack('C3')

      @identifier = val_to_sym(IDENTIFIER, identifier)
      @connector = val_to_sym(CONNECTOR, connector)
      @transciever = val_to_syms(TRANSCIEVER, transciever)
      @encoding = val_to_sym(ENCODING, encoding)
      @br = val_to_sym(BR, br)
      @rate_identifier = val_to_sym(RATE_IDENTIFIER, rate_identifier)
      @options = val_to_syms(OPTIONS, options)
      @diagnostic_monitoring_type = val_to_syms(DIAGNOSTIC_MONITORING_TYPE, diagnostic_monitoring_type)
      @enhanced_options = val_to_syms(ENHANCED_OPTIONS, enhanced_options)
    end

    def to_hexstr
      return to_hex.unpack("H*")[0]
    end

    def parse_hexstr(str)
      return false if str.length != 256
      parse_hex [str].pack("H*")
    end
  end
end
