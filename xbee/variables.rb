module Variables
  def destination
    send "ATDH"
    high = get

    send "ATDL"
    low = get

    high + low
  end

  def network
    send "ATID"
    get
  end

  def serial
    send "ATSH"
    high = get

    send "ATSL"
    low = get

    high + low
  end

  def power_level
    send "ATPL"
    get
  end

  def power_mode
    send "ATPM"
    get
  end

  def device_type
    send "ATDD"
    get
  end

  def channel
    send "ATCH"
    get
  end

  def firmware
    send "ATVR"
    get
  end

  def hardware
    send "ATHV"
    get
  end

end
