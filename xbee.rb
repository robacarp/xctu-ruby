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

  def connection
    @xbee
  end

  def initialize
    @xbee = SerialPort.new port, modem_config
    @xbee.read_timeout = 350
  rescue Errno::ENOENT => e
    puts "could not find serial port"
  end

end

xb = XBee.new
puts xb.connect ? 'connected' : 'cant connect'
# puts xb.network
puts xb.destination
# puts xb.reset! ? ' resetted ' : ' not as much resetted '
xb.abort
# puts xb.write! ? 'success' : 'fail'
# puts xb.power_level
# puts xb.power_mode
# puts xb.device_type
# puts xb.channel
puts xb.hup ? 'still good' : 'not good'
