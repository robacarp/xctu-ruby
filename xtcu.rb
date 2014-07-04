require 'serialport'

class XBee

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

  def nl
    "\r\n"
  end

  def send command, newline = true
    command << nl if newline
    print "\x1b[33m#{command}\x1b[0m"
    @xbee.write command
  end

  def get
    s = ""
    begin
      loop do
        s << @xbee.readchar
      end
    rescue EOFError
    end

    # p "received: " + s
    s.strip
  end

  def expect str
    str == get
  end

  def connect
    sleep 1
    send "+++", false
    sleep 1

    expect 'OK'
  end

  def hup
    send "AT"
    expect 'OK'
  end

  def destination
    send "ATDH"
    high = get

    send "ATDL"
    low = get

    high + low
  end

  def network
    send "ATID"
    get
  end

  def serial
    send "ATSH"
    high = get

    send "ATSL"
    low = get

    high + low
  end

  def power_level
    send "ATPL"
    get
  end

  def power_mode
    send "ATPM"
    get
  end

  def device_type
    send "ATDD"
    get
  end

  def channel
    send "ATCH"
    get
  end

  def firmware
    send "ATVR"
    get
  end

  def hardware
    send "ATHV"
    get
  end

  def reset!
    send "ATRE"
    get
    sleep 2
  end

  def write!
    send "ATWR"

    resp = ""
    start = Time.now.to_i

    # "Once WR is used, no additional characters should be
    # sent to the module until after the "OK\r" response
    # is received."
    begin

      begin
        loop do
          resp << @xbee.readchar
        end
      rescue EOFError
      end

      timeout = Time.now.to_i - start >= 4

    end while resp != "OK\r" && ! timeout

    ! timeout
  end

  def abort
    send "ATCN"
    get
  end

end

xb = XBee.new
puts xb.connect ? 'connected' : 'cant connect'
# puts xb.network
puts xb.destination
xb.abort
puts xb.write! ? 'success' : 'fail'
# puts xb.power_level
# puts xb.power_mode
# puts xb.device_type
# puts xb.channel
puts xb.hup ? 'still good' : 'not good'
