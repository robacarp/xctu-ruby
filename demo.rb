require './xbee'

xb = XBee.new

if xb.connect
  xb.fetch_config.dump
  xb.disconnect
else
  puts 'cant connect'
end

# puts xb.write! ? 'success' : 'fail'
# puts xb.hup ? 'still connected' : 'not connected'

