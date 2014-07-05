require 'serialport'

autoload :Commands,  './xbee/commands'
autoload :Macro,     './xbee/commands/macro'
autoload :Interface, './xbee/interface'
autoload :Variables, './xbee/variables'
autoload :Debug,     './xbee/debug'
autoload :Parameters, './xbee/parameters'

class XBee
  include Interface
  include Commands
  include Variables
  include Debug

  def modem_config
    modem_config = {
      'baud'      => 9600,
      'data_bits' => 8,
      'stop_bits' => 1,
      'parity'    => SerialPort::NONE,
    }
  end

  def port
    '/dev/tty.usbserial-A600eCAd'
  end

  def initialize
    @xbee = SerialPort.new port, modem_config
    @xbee.read_timeout = 350
    # debug_enable
  rescue Errno::ENOENT => e
    puts "could not find serial port"
  end
end

