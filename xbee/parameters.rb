class Parameters
  VARS = %w|DH DL ID CH SH SL DD VR PL PM V HV|

  VARS.each do |var|
    attr_accessor var.to_sym
  end

  def initialize variables = {}
    VARS.each do |var|
      self.send (var + '=').to_sym, ''
    end

    update variables
  end

  def update hash
    hash.keys.each do |var|
      self.send "#{var}=", hash[var] if self.methods.grep var
    end
  end

  def fetch_from xbee
    config = {
      DH: xbee.dh,
      DL: xbee.dl,
      SH: xbee.sh,
      SL: xbee.sl,
      ID: xbee.network,
      CH: xbee.channel,
      PL: xbee.power_level,
      PM: xbee.power_mode,
      V:  xbee.voltage,
      DD: xbee.device_type,
      VR: xbee.firmware,
      HV: xbee.hardware
    }

    update config
  end

  def write_to xbee
    xbee.dh = @DH
    xbee.dl = @DL

    xbee.network = @ID
    xbee.channel = @CH

    xbee.power_mode = @PM

    xbee.sample_rate = @IR
    xbee.sample_size = @IT
    xbee.remote_output_from = @IA
  end

  def dump
    puts 'Serial: '      + @SH + @SL
    puts 'Network: '     + @ID
    puts 'Destination: ' + @DH + @DL
    puts 'Channel: '     + @CH
    puts 'Device Type: ' + device_type
    puts 'Firmware: '    + firmware
    puts 'Hardware: '    + hardware
    puts 'Power Level: ' + power_level
    puts 'Power Mode: '  + power_mode
    puts 'Voltage: '     + voltage
  end

  def device_type
    "<device type #{@DD}>"
  end

  def firmware
    "<firmware #{@VR}>"
  end

  def hardware
    "<hardware #{@HV}>"
  end

  def power_level
    "<power level #{@PL}>"
  end

  def power_mode
    @PM == 1 ? 'boost' : 'normal'
  end

  def voltage
    "<voltage #{@V} >"
  end

end
