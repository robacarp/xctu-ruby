require './xbee'

xb = XBee.new
puts xb.connect ? 'connected' : 'cant connect'
puts xb.channel
puts xb.device_type
puts xb.firmware
puts xb.hardware
puts xb.power_level
puts xb.power_mode
puts xb.network
puts xb.destination

# puts xb.reset! ? ' resetted ' : ' not as much resetted '
xb.abort
# puts xb.write! ? 'success' : 'fail'
# puts xb.power_level
# puts xb.power_mode
# puts xb.device_type
# puts xb.channel
puts xb.hup ? 'still good' : 'not good'
