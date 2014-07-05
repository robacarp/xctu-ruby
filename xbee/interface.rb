module Interface
  extend Debug

  def send command, newline = true
    debug "\x1b[34m#{command}\x1b[0m"
    command << "\r\n" if newline
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

    s.strip!

    debug "\x1b[32m#{s}\x1b[0m"
    s
  end

  def expect str
    str == get
  end

end
