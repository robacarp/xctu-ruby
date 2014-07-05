require './xbee'

xb = XBee.new

if xb.connect!
  parameters = Parameters.new
  parameters.fetch_from xb
  parameters.dump

  puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

  parameters.DL = '55555555'

  parameters.write_to xb
  parameters.fetch_from xb
  parameters.dump

  puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
else
  puts 'cant connect'
end

# puts xb.write! ? 'success' : 'fail'
# puts xb.hup ? 'still connected' : 'not connected'

