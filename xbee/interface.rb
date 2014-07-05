module Interface

  def send command, newline = true
    command << "\r\n" if newline
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

end
