module Commands
  extend Macro

  command connect: "+++", enter: false, pre_sleep: 1, sleep: 1, expect: 'OK'
  command hup: "AT", expect: "OK"
  command reset!: "ATRE", sleep: 2
  command disconnect: "ATCN"

  def connect!
    if hup
      true
    else
      connect
    end
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

end
