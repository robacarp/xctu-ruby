class Parameters
  VARS = %w|DH DL ID CH SH SL DD VR PL PM V HV|

  VARS.each do |var|
    attr_accessor var.to_sym
  end

  def initialize variables
    VARS.each do |var|
      self.send (var + '=').to_sym, ''
    end

    variables.keys.each do |var|
      self.send "#{var}=", variables[var] if self.methods.grep var
    end
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
