require './xbee'

xb = XBee.new

if xb.connect 
  # puts 'connected'
  puts 'ID: '          + xb.id
  puts 'Serial: '      + xb.serial
  puts 'Network: '     + xb.network
  puts 'Channel: '     + xb.channel
  puts 'Device Type: ' + xb.device_type
  puts 'Firmware: '    + xb.firmware
  puts 'Hardware: '    + xb.hardware
  puts 'Power Level: ' + xb.power_level
  puts 'Power Mode: '  + xb.power_mode
  puts 'Voltage: '     + xb.voltage
  puts 'Destination: ' + xb.destination
  xb.disconnect
else
  puts 'cant connect'
end

# puts xb.write! ? 'success' : 'fail'
# puts xb.hup ? 'still connected' : 'not connected'

