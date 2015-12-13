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
      data.each_char{|c|
        ret = device.write(@addr, daddr, c)
        daddr += 1
        sleep 0.05
      }
      return ret
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
