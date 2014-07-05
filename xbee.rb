require 'serialport'

autoload :Commands,  './xbee/commands'
autoload :Macro,     './xbee/commands/macro'
autoload :Interface, './xbee/interface'
autoload :Variables, './xbee/variables'

class XBee
  include Interface
  include Commands
  include Variables

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
  rescue Errno::ENOENT => e
    puts "could not find serial port"
  end
end

