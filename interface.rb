def prompt
  opts = usage
      .split("\n")
      .map{ |opt| opt.split('-')[0] }
      .map{ |opt| opt.split(',') }
      .flatten
      .map(&:strip)
      .join(', ')

  print "Action? (#{opts}): "
  STDIN.readline
end

def usage
  <<-NOT_YET
o - Open xbee configuration file
s - Save xbee configuration file
N - edit parameter # N
  NOT_YET

  <<-END
r - Read configuration from XBee
w - Write configuration to XBee
d - Display parameter summary
q - Quit
?, h - show this Help
  END
end

def dump
  @params.dump
end

def act action
  action.strip!

  case action[0]
  when /h|\?/ then puts usage
  when /r/    then @params.fetch_from @xbee
  when /s/    then dump
  when /q/    then return false
  when /w/    then @params.write_to @xbee
  else
    puts "invalid option: #{action}" if action.length > 0
  end

  true
end

require './xbee'
require './xbee/parameters'

@xbee   = XBee.new
@params = Parameters.new

puts usage

loop do
  break unless act prompt
end

puts "Thanks for playing, now go build something!"
