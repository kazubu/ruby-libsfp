require 'i2c'

module SFP
  class RW
    def initialize(_path = '/dev/i2c-1', _addr = 0x50)
      @path = _path
      @addr = _addr
    end

    def read(length = 128)
      return device.read(@addr, length, 0)
    end

    def write(data)
      daddr = 0
      ret = 0
      data_block = data.each_char.each_slice(8).map(&:join)

      data_block.each{|d|
        ret = device.write(@addr, daddr, d)
        daddr += d.length
        sleep 0.05
      }
      return ret
    end

    def write_password(data)
      return nil if data.length != 4

      device.write(0x51, 0x7b, data)
    end


private

    def device
      if @device
        return @device
      else 
        @device = I2C.create(@path)
      end
    end
  end
end
